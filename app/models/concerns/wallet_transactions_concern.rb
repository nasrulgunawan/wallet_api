module WalletTransactionsConcern
  extend ActiveSupport::Concern

  included do
    has_many :credit_transactions, class_name: "Transaction", foreign_key: "target_wallet_id"
    has_many :debit_transactions, class_name: "Transaction", foreign_key: "source_wallet_id"
  end

  def balance
    wallet.balance
  end

  def all_transactions
    Transaction.where("source_wallet_id = :id OR target_wallet_id = :id", id: wallet.id)
      .order(created_at: :desc)
  end

  def debit_transactions
    all_transactions.where(transaction_type: :debit)
  end

  def credit_transactions
    all_transactions.where(transaction_type: :credit)
  end
end
