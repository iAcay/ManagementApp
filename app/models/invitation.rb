class Invitation < ApplicationRecord
  belongs_to :giver, class_name: 'User', inverse_of: :given_invitations
  belongs_to :receiver, class_name: 'User', inverse_of: :received_invitations
  belongs_to :account

  enum status: { pending: 0, accepted: 1, rejected: 2 }, _prefix: true
end
