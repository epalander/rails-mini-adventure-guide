class AdventurePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def create?
    return true
  end
  def new?
    return true
  end
  def index?
    return true
  end
  def show?
    return true
  end
  def search?
    return true
  end
  def edit?
    user.admin? || record.user_id == user.id
  end
  def update?
    user.admin? || record.user_id == user.id
  end
end
