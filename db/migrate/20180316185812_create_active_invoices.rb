class CreateActiveInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :active_invoices do |t|
      t.datetime :date_of_issue
      t.boolean :collected, default: false
      t.datetime :deadline
      t.string :serial_number, default: ''
      t.string :description, default: ''

      t.references :user, foreign_key: true
    end
  end
end
