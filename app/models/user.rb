class User < ApplicationRecord
  has_secure_password

  has_one :wallet, as: :owner, class_name: "UserWallet"

  has_one :session_token, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }

  after_create :create_wallet

  private

  def create_wallet
    self.create_wallet!
  end
end
