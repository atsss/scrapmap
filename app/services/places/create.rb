module Places
  class Create < ApplicationService
    include Rails.application.routes.url_helpers

    integer :channel_id
    string :name
    float :lat
    float :lng
    string :note, default: nil

    if Rails.env.production?
      string :images, default: nil
    else
      object :images, class: ActionDispatch::Http::UploadedFile, default: nil
    end

    validates :name, :lat, :lng, presence: true

    def execute
      place = Place.new(channel_id: channel_id, name: name, lat: lat, lng: lng)

      transaction do
        place.save!
        place.notes.create!(content: note, images: images) if note.present? || images.present?
      end

      send_slack(place)
      place
    end

    private

    def send_slack(place)
      messenger = Messenger.new(:slack, 'cocchi')
      messenger.push!("New post!\n#{place_url(place)}")
    end
  end
end
