# == Schema Information
#
# Table name: user_communities
#
#  id           :bigint           not null, primary key
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  community_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_user_communities_on_community_id  (community_id)
#  index_user_communities_on_deleted_at    (deleted_at)
#  index_user_communities_on_user_id       (user_id)
#
class UserCommunity < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :community

  validates :user_id, uniqueness: { scope: :community_id }
end
