class AddSerialNumberToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :serial_number, :integer
  end
end
