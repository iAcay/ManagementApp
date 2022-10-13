class ProjectPolicy < ApplicationPolicy
  def edit?
    user.administered_account == record
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
