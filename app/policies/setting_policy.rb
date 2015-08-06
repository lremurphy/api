class SettingPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.admin?
  end

  def show?
    true
  end

  def new?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def permitted_parameters
    if user.admin?
    end
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
