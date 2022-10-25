class Account < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :projects, dependent: :destroy
  has_many :invitations, dependent: :destroy
  belongs_to :admin, class_name: 'User', inverse_of: :administered_account
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  enum plan: { free: 0, premium: 1 }, _prefix: true
end
