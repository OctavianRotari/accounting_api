class AddVatToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :vat, :decimal
  end
end
