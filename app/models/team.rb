class Team < ApplicationRecord
  include WalletTransactionsConcern

  has_one :wallet, as: :owner, class_name: "TeamWallet"
end
