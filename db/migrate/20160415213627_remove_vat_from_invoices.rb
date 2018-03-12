class RemoveVatFromInvoices < ActiveRecord::Migration[5.1]
  def change
    remove_column :invoices, :vat, :integer
  end
end
