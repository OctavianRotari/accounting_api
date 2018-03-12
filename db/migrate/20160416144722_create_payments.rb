class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.decimal :total
      t.string :method_of_payment
      t.datetime :date

      t.timestamps null: true
    end
  end
end
