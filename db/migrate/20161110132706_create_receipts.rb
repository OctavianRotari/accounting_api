class CreateReceipts < ActiveRecord::Migration[5.1]
  def change
    create_table :receipts do |t|
      t.decimal :paid
      t.string :method_of_payment
      t.string :policy_number
      t.datetime :payment_date

      t.timestamps null: true
    end
  end
end
