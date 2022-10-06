class RemoveUserIdFromAccounts < ActiveRecord::Migration[7.0]
  def change
    remove_column :accounts, :user_id, index: true, foreign_key: true
  end
end
