class RemoveSupplierFromInvoices < ActiveRecord::Migration[5.1]
  def change
    remove_column :invoices, :supplier, :string
  end
end
