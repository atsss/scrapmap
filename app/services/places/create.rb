module Places
  class Create < ApplicationService
    include Rails.application.routes.url_helpers

    string :name
    float :lat
    float :lng
    string :note
    object :images, class: ActionDispatch::Http::UploadedFile, default: nil

    validates :name, :lat, :lng, :note, presence: true

    def execute
      place = Place.new(name: name, lat: lat, lng: lng)

      transaction do
        place.save!
        place.notes.create!(content: note, images: images)
      end

      send_slack(place)
      place
    end

    private

    def send_slack(place)
      messenger = Messenger.new(:slack, 'cocchi', '_title')
      messenger.push!("New post!\n#{place_url(place)}")
    end
  end
end
