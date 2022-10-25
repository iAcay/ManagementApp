class AddAccountIdToInvitations < ActiveRecord::Migration[7.0]
  def change
    add_reference :invitations, :account, foreign_key: true
  end
end
