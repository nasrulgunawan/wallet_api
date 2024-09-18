class Stock < ApplicationRecord
  has_one :wallet, as: :owner, class_name: "StockWallet"
end
