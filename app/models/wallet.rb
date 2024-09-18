class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
