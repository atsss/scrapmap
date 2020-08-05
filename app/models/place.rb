# == Schema Information
#
# Table name: places
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
#  google_map_url :string(255)
#  lat            :float(24)
#  lng            :float(24)
#  name           :string(255)
#  uber_eats_url  :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  channel_id     :bigint
#
# Indexes
#
#  index_places_on_channel_id  (channel_id)
#  index_places_on_deleted_at  (deleted_at)
#
class Place < ApplicationRecord
  acts_as_paranoid

  belongs_to :channel
  has_many :notes, dependent: :restrict_with_error
  validates :name, presence: true

  def need_check?
    lat.nil? || lng.nil?
  end
end
