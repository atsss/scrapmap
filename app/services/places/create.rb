module Places
  class Create < ApplicationService
    include Rails.application.routes.url_helpers

    object :user
    integer :channel_id
    string :name
    float :lat
    float :lng
    string :google_map_url, default: nil
    string :note, default: nil

    if Rails.env.production?
      string :images, default: nil
    else
      object :images, class: ActionDispatch::Http::UploadedFile, default: nil
    end

    validates :user, :channel_id, :name, :lat, :lng, presence: true

    def execute
      place = Place.new(place_attributes)

      transaction do
        place.save!
        place.notes.create!(user: user, content: note.presence, images: images) \
          if note.present? || images.present?
      end

      send_slack_to_admin(place) if place.google_map_url
      send_notification(place)
      place
    end

    private

    def place_attributes
      {
        channel_id: channel_id,
        name: name,
        lat: google_map_url.present? ? nil : lat,
        lng: google_map_url.present? ? nil : lng,
        google_map_url: google_map_url.presence
      }
    end

    def send_notification(place)
      messenger = Messenger.new(:slack, 'cocchi')
      messenger.push!("New post!\n#{place_url(place)}")
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
