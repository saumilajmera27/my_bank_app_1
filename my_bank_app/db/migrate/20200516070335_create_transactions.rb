class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.string :account_from
      t.string :account_to
      t.float :amount
      t.timestamps
    end
  end
end
