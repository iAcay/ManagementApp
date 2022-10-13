class AccountPolicy < ApplicationPolicy
  def edit?
    user.administered_account == record
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def new_user_to_account?
    edit?
  end

  def add_user_to_account?
    edit?
  end
end
