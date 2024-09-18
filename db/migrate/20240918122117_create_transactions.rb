class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.references :source_wallet, foreign_key: { to_table: :wallets }
      t.references :target_wallet, foreign_key: { to_table: :wallets }
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.integer :transaction_type, null: false
      t.integer :transaction_category, null: false

      t.timestamps
    end
  end
end
