# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  place_id   :bigint           not null
#  user_id    :bigint
#
# Indexes
#
#  index_notes_on_deleted_at  (deleted_at)
#  index_notes_on_place_id    (place_id)
#  index_notes_on_user_id     (user_id)
#
class Note < ApplicationRecord
  acts_as_paranoid

  belongs_to :place
  belongs_to :user
  has_many_attached :images
  validates :content, presence: true, unless: proc { |note| note.images.attached? }
end
