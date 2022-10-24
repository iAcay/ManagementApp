class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :account, optional: true
  has_one :administered_account, class_name: 'Account', foreign_key: :admin, inverse_of: :admin, dependent: :nullify
  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many :given_invitations, class_name: 'Invitation', foreign_key: 'giver', inverse_of: :giver, dependent: :destroy
  has_many :received_invitations, class_name: 'Invitation', foreign_key: 'receiver', inverse_of: :receiver, dependent: :destroy

  after_create do
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end
end
