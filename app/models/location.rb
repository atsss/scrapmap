# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  lat        :decimal(9, 6)
#  lng        :decimal(9, 6)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Location < ApplicationRecord
  has_many :places, dependent: :restrict_with_error
  has_many :channels, through: :places

  def need_check?
    lat.nil? || lng.nil?
  end
end
