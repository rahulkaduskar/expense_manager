class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.string :description
      t.integer :paid_by
      t.integer :paid_to
      t.integer :group_id
      t.integer :amount

      t.timestamps null: false
    end
  end
end
