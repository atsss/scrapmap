class PlacePolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    true
  end

  def create?
    record.channel.community.in?(user.communities)
  end

  def edit?
    new?
  end

  def update?
    create?
  end
end
