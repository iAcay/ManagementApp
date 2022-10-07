class HomeController < ApplicationController
  def index
    @projects = (ActsAsTenant.current_tenant.present? ? ActsAsTenant.current_tenant.projects : []) 
  end
end
