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
#
class Place < ApplicationRecord
  has_many :notes, dependent: :restrict_with_error
  validates :name, :lat, :lng, presence: true
end
