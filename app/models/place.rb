# == Schema Information
#
# Table name: places
#
#  id         :bigint           not null, primary key
#  lat        :float(24)
#  lng        :float(24)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  channel_id :bigint
#
# Indexes
#
#  index_places_on_channel_id  (channel_id)
#
class Place < ApplicationRecord
  belongs_to :channel
  has_many :notes, dependent: :restrict_with_error
  validates :name, :lat, :lng, presence: true
end
