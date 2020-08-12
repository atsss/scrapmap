module Places
  class Create < ApplicationService
    include Rails.application.routes.url_helpers

    object :user
    integer :channel_id
    string :name
    float :lat, default: nil
    float :lng, default: nil
    string :google_map_url, default: nil
    string :note, default: nil

    if Rails.env.production?
      string :images, default: nil
    else
      object :images, class: ActionDispatch::Http::UploadedFile, default: nil
    end

    validates :user, :channel_id, :name, presence: true

    def execute
      if invalid_location_infomation?
        errors.add(:base, I18n.t('error.location'))

        return
      end

      place = Place.new(place_attributes)

      transaction do
        place.save!
        place.notes.create!(user: user, content: note.presence, images: images) \
          if note.present? || images.present?
        calculate_center_position!(channel: Channel.find(channel_id))
      end

      send_slack_to_admin(place) if place.google_map_url
      send_notification(place) if place.channel.community.kind.public?
      place
    end

    private

    def invalid_location_infomation?
      return false if google_map_url.presence
      return false if lat.presence && lng.presence

      true
    end

    def place_attributes
      {
        channel_id: channel_id,
        name: name,
        lat: google_map_url.present? ? nil : lat,
        lng: google_map_url.present? ? nil : lng,
        google_map_url: google_map_url.presence
      }
    end

    def calculate_center_position!(channel: nil)
      places = channel.places.reject(&:need_check?)
      size = places.size
      center_lat = places.sum(&:lat) / size
      center_lng = places.sum(&:lng) / size

      channel.update!(center_lat: center_lat, center_lng: center_lng)
    end

    def send_notification(place)
      messenger = Messenger.new(:slack, place.channel.community.name.downcase)
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

      messenger = Messenger.new(:slack, 'notification')
      messenger.push!("緯度経度の代理入力\n#{admin_url}")
    end
  end
end
