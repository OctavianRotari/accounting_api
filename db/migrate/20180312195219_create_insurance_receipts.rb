class CreateInsuranceReceipts < ActiveRecord::Migration[5.2]
  def change
    t.decimal :paid
    t.string :method_of_payment
    t.string :policy_number
    t.datetime :payment_date
    t.timestamps null: true

    t.references :insurace, foreign_key: true
  end
end
