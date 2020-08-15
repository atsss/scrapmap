# == Schema Information
#
# Table name: places
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
#  google_map_url :string(255)
#  kind           :string(255)
#  lat            :float(24)
#  lng            :float(24)
#  name           :string(255)
#  uber_eats_url  :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  channel_id     :bigint
#  location_id    :bigint
#  original_id    :bigint
#
# Indexes
#
#  index_places_on_channel_id   (channel_id)
#  index_places_on_deleted_at   (deleted_at)
#  index_places_on_location_id  (location_id)
#  index_places_on_original_id  (original_id)
#
class Place < ApplicationRecord
  acts_as_paranoid

  belongs_to :channel
  belongs_to :location
  belongs_to :original, class_name: 'Place', optional: true
  has_many :notes, dependent: :restrict_with_error
  validates :name, presence: true

  delegate :lat, :lng, :need_check?, to: :location
end
