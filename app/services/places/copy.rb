module Places
  class Copy < ApplicationService
    include Rails.application.routes.url_helpers

    object :place
    integer :channel_id
    string :name
    string :kind

    validates :place, :channel_id, :kind, :name, presence: true

    def execute
      if invalid_channel?
        errors.add(:base, I18n.t('error.same_channel'))

        return
      end

      place = Place.new(place_attributes)

      transaction do
        place.save!
        Channel.update_center_position!(channel_id)
      end

      send_notification(place) if place.channel.community.kind.public?
      place
    end

    private

    def invalid_channel?
      channel_id == place.channel_id
    end

    def place_attributes
      {
        channel_id: channel_id,
        location_id: place.location.id,
        original_id: place.id,
        name: name,
        kind: kind
      }
    end

    def send_notification(place)
      messenger = Messenger.new(:slack, place.channel.community.name.downcase)
      messenger.push!("New post!\n#{place_url(place)}")
    end
  end
end
