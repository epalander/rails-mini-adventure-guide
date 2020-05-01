class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def destroy?
    user.admin? or not post.published?
  end
end
