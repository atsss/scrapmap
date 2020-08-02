# == Schema Information
#
# Table name: channels
#
#  id           :bigint           not null, primary key
#  deleted_at   :datetime
#  name         :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  community_id :bigint
#
# Indexes
#
#  index_channels_on_community_id  (community_id)
#  index_channels_on_deleted_at    (deleted_at)
#
class Channel < ApplicationRecord
  acts_as_paranoid

  belongs_to :community
  has_many :places, dependent: :restrict_with_error
  validates :name, presence: true
end
