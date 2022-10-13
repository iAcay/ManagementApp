class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :account, optional: true
  has_one :administered_account, class_name: 'Account', foreign_key: :admin, inverse_of: :admin, dependent: :nullify
  has_many :user_projects
  has_many :projects, through: :user_projects

  after_create do
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end
end
