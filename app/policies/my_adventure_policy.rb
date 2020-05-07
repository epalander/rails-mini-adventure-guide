class MyAdventurePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

## For update function later
  def update?
    true
  end

  def destroy?
    user.admin? || record.user_id == user.id
  end
end
