module HomeHelper
  def organization_name
    if ActsAsTenant.current_tenant.present?
      ActsAsTenant.current_tenant.name
    end
  end
end
