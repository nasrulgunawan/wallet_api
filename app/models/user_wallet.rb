class UserWallet < Wallet
  belongs_to :user, foreign_key: :owner_id
end
