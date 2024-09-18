class CreateSessionTokens < ActiveRecord::Migration[7.2]
  def change
    create_table :session_tokens do |t|
      t.string :token, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
