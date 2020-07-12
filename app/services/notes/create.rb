module Notes
  class Create < ApplicationService
    include Rails.application.routes.url_helpers

    object :place
    string :content

    if Rails.env.production?
      string :images, default: nil
    else
      object :images, class: ActionDispatch::Http::UploadedFile, default: nil
    end

    validates :place, :content, presence: true

    def execute
      note = place.notes.create!(content: content, images: images)

      send_slack(place)
      note
    end

    private

    def send_slack(place)
      messenger = Messenger.new(:slack, 'cocchi', '_title')
      messenger.push!("Add new note!\n#{place_url(place)}")
    end
  end
end
