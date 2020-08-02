module Notes
  class Create < ApplicationService
    include Rails.application.routes.url_helpers

    object :user
    object :place
    string :content

    if Rails.env.production?
      string :images, default: nil
    else
      object :images, class: ActionDispatch::Http::UploadedFile, default: nil
    end

    validates :user, :place, presence: true
    validates :content, presence: true, if: proc { |form| form.images.blank? }
    validates :images, presence: true, if: proc { |form| form.content.blank? }

    def execute
      note = place.notes.create!(user: user, content: content.presence, images: images)

      send_notification(place) if place.channel.community.kind.public?
      note
    end

    private

    def send_notification(place)
      messenger = Messenger.new(:slack, 'cocchi')
      messenger.push!("Add new note!\n#{place_url(place)}")
    end
  end
end
