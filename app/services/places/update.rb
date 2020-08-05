module Places
  class Update < ApplicationService
    object :place
    string :name
    string :google_map_url, default: nil

    if Rails.env.production?
      string :images, default: nil
    else
      object :images, class: ActionDispatch::Http::UploadedFile, default: nil
    end

    validates :place, :name, presence: true

    def execute
      place.update!(attributes)

      send_slack_to_admin(place) if place.google_map_url
      place
    end

    private

    def attributes
      if google_map_url.presence
        { name: name, google_map_url: google_map_url, lat: nil, lng: nil }
      else
        { name: name }
      end
    end

    def send_slack_to_admin(place)
      admin_url = RailsAdmin
                    .railtie_routes_url_helpers
                    .edit_url(
                      model_name: 'place',
                      id: place.id,
                      host: ENV.fetch('ORIGIN_DOMAIN') { '127.0.0.1' }
                    )

      messenger = Messenger.new(:slack, 'cocchi-test')
      messenger.push!("緯度経度の代理入力\n#{admin_url}")
    end
  end
end
