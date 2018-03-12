class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.string :supplier
      t.integer :total
      t.integer :vat
      t.datetime :date
      t.string :plate
      t.datetime :deadline
      t.string :type_of_payment
      t.timestamps null: true
    end
  end
end
