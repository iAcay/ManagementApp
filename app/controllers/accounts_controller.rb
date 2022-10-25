class AccountsController < ApplicationController
  def new
    if current_user.account.present?
      redirect_to root_path, notice: 'You already have an account.'
    else
      render :new, locals: { account: Account.new }
    end
  end

  def edit
    authorize account

    render :edit, locals: { account: account }
  end

  def create
    account = Account.new(account_params)
    account.users << current_user
    account.admin = current_user

    if account.save
      redirect_to root_path, notice: 'Your account was successfully configured!'
    else
      render :new, locals: { account: account }
    end
  end

  def update
    authorize account

    if account.update(account_params)
      redirect_to root_path, notice: 'Your account was successfully updated.'
    else
      render :edit, locals: { account: account }
    end
  end

  def destroy
    authorize account 
    if account.destroy
      redirect_to root_path, notice: 'Your organization was successfully deleted.'
    else
      redirect_to root_path, notice: 'Something went wrong :('
    end
  end

  def new_user_to_account
    account = ActsAsTenant.current_tenant
    invitations = account.invitations.where(status: :pending)
    authorize account

    render :new_user_to_account, locals: { invitations: invitations }
  end

  def invite_user_to_account
    account = ActsAsTenant.current_tenant
    authorize account
    giver = current_user
    receiver = User.find_by(email: params[:receiver_email])

    if receiver.nil?
      redirect_to new_user_to_account_path, alert: 'User not found :('
    elsif Invitation.create(giver: giver, receiver: receiver, account: account)
      redirect_to new_user_to_account_path, notice: 'User was invited to your organization!'
    else
      redirect_to new_user_to_account_path, alert: 'Something went wrong.'
    end
  end

  def cancel_invitation
    invitation = Invitation.find(params[:invitation])

    invitation.destroy

    redirect_to new_user_to_account_path, notice: 'Invitation was canceled.'
  end

  def recognize_invitation
    invitation = Invitation.find(params[:invitation])
    
    if params[:decision] == 'accept'
      invitation.account.users << invitation.receiver
      invitation.status_accepted!
      redirect_to root_path, notice: "You are member of #{invitation.account.name} now."
    else
      invitation.status_rejected!
      redirect_to invitations_path, notice: "You rejected invitation from #{invitation.account.name}."
    end
  end

  private

  def account
    @account ||= Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :plan)
  end
end
