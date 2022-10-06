class AddPlanToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :name, :string, index: { unique: true }
    add_column :accounts, :plan, :integer, default: 0, null: false
  end
end
