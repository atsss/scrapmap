# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_one :account, dependent: :restrict_with_error
  has_one_attached :image
  has_many :notes, dependent: :restrict_with_error

  validates :name, presence: true
end