module Places
  class Create < ApplicationService
    string :name
    float :lat
    float :lon
    string :note
    array :images, default: nil do
      object class: ActionDispatch::Http::UploadedFile
    end

    validates :name, :lat, :lon, :note, presence: true

    def execute
      place = Place.new(name: name, lat: lat, lon: lon)

      transaction do
        place.save!
        place.notes.create!(content: note, images: images)
      end

      place
    end
  end
end
