class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  set_current_tenant_through_filter
  before_action :set_current_tenant

  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  private

  def set_current_tenant
    return unless current_user.present?
    current_account = current_user.account
    ActsAsTenant.current_tenant = current_account
  end

  def user_not_authorized
    redirect_back fallback_location: root_path, alert: 'You are not authorized.'
  end
end
