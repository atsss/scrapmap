# == Schema Information
#
# Table name: channels
#
#  id           :bigint           not null, primary key
#  center_lat   :float(24)
#  center_lng   :float(24)
#  deleted_at   :datetime
#  kind         :string(255)
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
  extend Enumerize
  acts_as_paranoid

  enumerize :kind, in: %i(draft normal), default: :normal, scope: true

  DEFAULT_NAMES = %w(カフェ 居酒屋 買い物 旅行).freeze

  belongs_to :community
  has_many :places, dependent: :restrict_with_error
  has_many :locations, through: :places
  validates :name, presence: true

  class << self
    def update_center_position!(id)
      channel = find(id)
      places = channel.places.reject(&:need_check?)
      size = places.size

      return if size.zero?

      center_lat = places.sum(&:lat) / size
      center_lng = places.sum(&:lng) / size

      channel.update!(center_lat: center_lat, center_lng: center_lng)
    end
  end
end
