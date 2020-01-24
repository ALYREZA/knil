class LinkPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    if user.status == 0
      false
    else
      true
    end
  end

  def update?
    true
  end
end
