class ChannelPolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    true
  end

  def create?
    record.community.in?(user.communities)
  end

  def edit?
    new?
  end

  def update?
    create?
  end
end
