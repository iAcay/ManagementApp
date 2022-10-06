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

  private

  def account_params
    params.require(:account).permit(:name, :plan)
  end
end
