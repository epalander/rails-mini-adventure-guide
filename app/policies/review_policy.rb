class ReviewPolicy < ApplicationPolicy
  # before_action :authenticate_user!

  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def create?
    return true
  end

  def destroy?
    user.admin? || record.user_id == user.id
  end

  def edit?
    user.admin? || record.user_id == user.id
  end
end
