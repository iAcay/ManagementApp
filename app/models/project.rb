class Project < ApplicationRecord
  acts_as_tenant :account
  validates :title, uniqueness: { case_sensitive: false }
  validates_with FreePlanOneProjectValidator
end
