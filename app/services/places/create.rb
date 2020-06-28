module Places
  class Create < ApplicationService
    string :name
    float :lat
    float :lon
    string :note
    object :image, class: ActionDispatch::Http::UploadedFile, default: nil

    validates :name, :lat, :lon, :note, presence: true

    def execute
      place = Place.new(name: name, lat: lat, lon: lon)

      transaction do
        place.save!
        place.notes.create!(content: note, image: image)
      end

      place
    end
  end
end
