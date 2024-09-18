class StockWallet < Wallet
  belongs_to :stock, foreign_key: :owner_id
end
