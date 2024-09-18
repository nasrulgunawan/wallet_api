class Team < ApplicationRecord
  has_one :wallet, as: :owner, class_name: "TeamWallet"
end
