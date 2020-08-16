class NotePolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    new?
  end

  def update?
    create?
  end

  def destroy?
    update?
  end
end
