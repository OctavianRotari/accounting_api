class AddVendorIdToActiveInvoices < ActiveRecord::Migration[5.2]
  def change
    add_reference :active_invoices, :vendor, foreign_key: true
  end
end