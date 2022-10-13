class Project < ApplicationRecord
  acts_as_tenant :account
  has_many :artifacts, dependent: :destroy
  has_many :user_projects
  has_many :users, through: :user_projects

  validates :title, uniqueness: { case_sensitive: false }
  validates_with FreePlanOneProjectValidator
end
