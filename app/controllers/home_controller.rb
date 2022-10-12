class HomeController < ApplicationController
  def index
    account = ActsAsTenant.current_tenant
    projects = (account.present? ? account.projects : []) 
    render :index, locals: { projects: projects, account: account}
  end
end
