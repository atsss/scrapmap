module Places
  class Draft < ApplicationService
    object :user
    float :lat, default: nil
    float :lng, default: nil

    if Rails.env.production?
      string :images, default: nil
    else
      object :images, class: ActionDispatch::Http::UploadedFile, default: nil
    end

    validates :user, :images, presence: true

    def execute
      if invalid_location_infomation?
        errors.add(:base, I18n.t('error.location'))

        return
      end

      location = Location.new(lat: lat, lng: lng)
      place = Place.new(channel: target_draft_channel, name: 'No name', kind: :wanted)

      transaction do
        location.save!

        place.location = location
        place.save!

        place.notes.create!(user: user, images: images)
        Channel.update_center_position!(target_draft_channel.id)
      end

      place
    end

    private

    def invalid_location_infomation?
      return false if lat.presence && lng.presence

      true
    end

    def target_draft_channel
      user.private_community.channels.with_kind(:draft).first
    end
  end
end
