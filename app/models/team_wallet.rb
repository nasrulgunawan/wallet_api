class TeamWallet < Wallet
  belongs_to :team, foreign_key: :owner_id
end
