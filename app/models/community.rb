# == Schema Information
#
# Table name: communities
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  kind       :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_communities_on_deleted_at  (deleted_at)
#
class Community < ApplicationRecord
  acts_as_paranoid

  has_many :user_communities, dependent: :restrict_with_error
  has_many :users, through: :user_communities

  validates :name, :kind, presence: true
end
