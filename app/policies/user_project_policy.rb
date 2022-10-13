class UserProjectPolicy < ApplicationPolicy
  def create?
    user.administered_account == record
  end

  def destroy
    create?
  end
end
