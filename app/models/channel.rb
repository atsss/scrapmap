# == Schema Information
#
# Table name: channels
#
#  id           :bigint           not null, primary key
#  center_lat   :float(24)
#  center_lng   :float(24)
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

  DEFAULT_NAMES = %w(下書き カフェ 居酒屋 買い物 旅行).freeze

  belongs_to :community
  has_many :places, dependent: :restrict_with_error
  has_many :locations, through: :places
  validates :name, presence: true
end
