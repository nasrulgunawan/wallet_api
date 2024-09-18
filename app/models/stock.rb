class Stock < ApplicationRecord
  include WalletTransactionsConcern

  has_one :wallet, as: :owner, class_name: "StockWallet"
end
