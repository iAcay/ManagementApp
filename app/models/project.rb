class Project < ApplicationRecord
  acts_as_tenant :account
  has_many :artifacts, dependent: :destroy
  validates :title, uniqueness: { case_sensitive: false }
  validates_with FreePlanOneProjectValidator
end
