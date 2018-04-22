class ChangeCompanyIdToVendorIdInFuelReceipts < ActiveRecord::Migration[5.2]
  def change
    rename_column :fuel_receipts, :company_id, :vendor_id
  end
end
