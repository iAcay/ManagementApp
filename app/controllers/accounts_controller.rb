class AccountsController < ApplicationController
  def new
    if current_user.account.present?
      redirect_to root_path, notice: 'You already have an account.'
    else
      render :new, locals: { account: Account.new }
    end
  end

  def create
    account = Account.new(account_params)
    account.users << current_user

    if account.save
      redirect_to root_path, notice: 'Your account was successfully configured!'
    else
      render :new, locals: { account: account }
    end
  end

  def new_user_to_account
    render :new_user_to_account
  end

  def add_user_to_account
    new_user = User.find_by(email: params[:email])
    current_organization = ActsAsTenant.current_tenant
    if new_user.nil?
      redirect_to new_user_to_account_path, alert: 'User not found :('
    elsif current_organization.users << new_user
      redirect_to root_path, notice: 'User was successfully added to your organization!'
    else
      redirect_to new_user_to_account_path, alert: 'Something went wrong.'
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :plan)
  end
end
