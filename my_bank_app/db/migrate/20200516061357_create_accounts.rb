class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :account_no
      t.float :balance, :default =>  0.0
      t.timestamps
    end
  end
end
