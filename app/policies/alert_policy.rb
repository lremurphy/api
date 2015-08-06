class AlertPolicy < ApplicationPolicy
  # TODO: MAKE THIS POLICY REFLECT THE DIFFERENT WAYS AN ALERT CAN BE ASSOCIATED WITH OTHER ENTITIES IN THE SYSTEM
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def permitted_attributes
    if user.admin?
      [:id, :status, :message, :category, :start_date, :end_date, :alertable_type, :alertable_id]
    end
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        # TODO: MAKE ALERTS A USER CREATED AND ALERTS ASSIGNED TO A USER TWO SCOPES?
        user.alerts
      end
    end
  end
end
