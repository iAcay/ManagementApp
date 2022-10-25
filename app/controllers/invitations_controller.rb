class InvitationsController < ApplicationController
  
  def index
    render :index, locals: { invitations: Invitation.where(status: :pending, receiver: current_user) }
  end
end
