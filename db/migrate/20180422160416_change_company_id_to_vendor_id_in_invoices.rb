class ChangeCompanyIdToVendorIdInInvoices < ActiveRecord::Migration[5.2]
  def change
    rename_column :invoices, :company_id, :vendor_id
  end
end
