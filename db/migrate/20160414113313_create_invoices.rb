class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.datetime :date_of_issue
      t.datetime :deadline
      t.timestamps null: true

      t.decimal :total_vat
      t.string :reason
      t.decimal :total_taxable
      t.string :type_of_invoice
      t.string :at_the_expense_of
      t.boolean :paid, default: false
      t.string :serial_number
      t.boolean :general_expence, default: false
    end
  end
end
