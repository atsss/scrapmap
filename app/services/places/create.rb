module Places
  class Create < ApplicationService
    string :name
    float :lat
    float :lng
    string :note
    array :images, default: nil do
      object class: ActionDispatch::Http::UploadedFile
    end

    validates :name, :lat, :lng, :note, presence: true

    def execute
      place = Place.new(name: name, lat: lat, lng: lng)

      transaction do
        place.save!
        place.notes.create!(content: note, images: images)
      end

      place
    end
  end
end
