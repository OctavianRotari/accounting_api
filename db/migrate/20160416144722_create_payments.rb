class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.decimal :paid
      t.string :method_of_payment
      t.datetime :payment_date

      t.timestamps null: true
      t.references :invoice, foreign_key: true
    end
  end
end
