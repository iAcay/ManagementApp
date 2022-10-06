module HomeHelper
  def organization_name
    if ActsAsTenant.current_tenant.present?
      ActsAsTenant.current_tenant.name
    end
  end

  def organization_members
    if ActsAsTenant.current_tenant.present?
      organization_members = ActsAsTenant.current_tenant.users
    end
  end
end
