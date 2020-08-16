module Places
  class Update < ApplicationService
    object :place
    integer :channel_id
    string :name
    string :kind
    float :lat
    float :lng
    string :google_map_url, default: nil

    if Rails.env.production?
      string :images, default: nil
    else
      object :images, class: ActionDispatch::Http::UploadedFile, default: nil
    end

    validates :place, :name, presence: true

    def execute
      transaction do
        place.update!(attributes)
        place.location.update!(lat: lat, lng: lng)
      end

      send_slack_to_admin(place.location) if google_map_url.presence
      place
    end

    private

    def attributes
      if google_map_url.presence
        { channel_id: channel_id, name: name, kind: kind, google_map_url: google_map_url }
      else
        { channel_id: channel_id, name: name, kind: kind }
      end
    end

    def send_slack_to_admin(location)
      admin_url = RailsAdmin
                    .railtie_routes_url_helpers
                    .edit_url(
                      model_name: 'location',
                      id: location.id,
                      host: ENV.fetch('ORIGIN_DOMAIN') { '127.0.0.1' }
                    )

      messenger = Messenger.new(:slack, 'notification')
      messenger.push!("緯度経度の代理入力\n#{admin_url}\n#{google_map_url}")
    end
  end
end
