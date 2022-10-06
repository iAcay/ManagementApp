class AddDeatilasToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :title, :string
    add_column :projects, :details, :text
    add_column :projects, :expected_completion_date, :date
  end
end
