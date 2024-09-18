class Transaction < ApplicationRecord
  enum :transaction_type, [ :debit, :credit ]
  enum :transaction_category, [ :deposit, :withdrawal, :transfer ]

  belongs_to :source_wallet, class_name: "Wallet", optional: true
  belongs_to :target_wallet, class_name: "Wallet", optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, :transaction_category, presence: true
  validate :wallets_validation

  def self.create_deposit(wallet:, amount:)
    Wallet.transaction do
      create!(
        source_wallet: nil,
        target_wallet: wallet,
        amount: amount,
        transaction_type: :credit,
        transaction_category: :deposit
      )

      wallet.increment!(:balance, amount)
    end
  end

  def self.create_withdrawal(wallet:, amount:)
    raise ActionController::BadRequest, "Amount cannot be blank" if amount.blank?
    raise ActionController::BadRequest, "Insufficient balance" if wallet.balance < amount

    Wallet.transaction do
      create!(
        source_wallet: wallet,
        target_wallet: nil,
        amount: amount,
        transaction_type: :debit,
        transaction_category: :withdrawal
      )

      wallet.decrement!(:balance, amount)
    end
  end

  def self.create_transfer(source_wallet:, target_wallet:, amount:)
    raise ActionController::BadRequest, "Cannot transfer to the same wallet" if source_wallet == target_wallet
    raise ActionController::BadRequest, "Amount cannot be blank" if amount.blank?
    raise ActionController::BadRequest, "Insufficient balance" if source_wallet.balance < amount

    Wallet.transaction do
      create!(
        source_wallet: source_wallet,
        target_wallet: target_wallet,
        amount: amount,
        transaction_type: :credit,
        transaction_category: :transfer
      )

      create!(
        source_wallet: source_wallet,
        target_wallet: target_wallet,
        amount: amount,
        transaction_type: :debit,
        transaction_category: :transfer
      )

      source_wallet.decrement!(:balance, amount)
      target_wallet.increment!(:balance, amount)
    end
  end

  private

  def wallets_validation
    case transaction_category
    when "deposit"
      errors.add(:target_wallet, "must be present for deposits") if target_wallet.nil?
    when "withdrawal"
      errors.add(:source_wallet, "must be present for withdrawals") if source_wallet.nil?
    when "transfer"
      errors.add(:source_wallet, "must be present for transfers") if source_wallet.nil?
      errors.add(:target_wallet, "must be present for transfers") if target_wallet.nil?
    end
  end
end
