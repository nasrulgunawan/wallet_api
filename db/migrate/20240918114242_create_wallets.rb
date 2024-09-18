class CreateWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :wallets do |t|
      t.references :owner, null: false, polymorphic: true
      t.string :type, null: false
      t.decimal :balance, null: false, default: 0

      t.timestamps
    end

    add_index :wallets, :type
  end
end
