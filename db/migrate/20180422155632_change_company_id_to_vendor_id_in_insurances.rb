class ChangeCompanyIdToVendorIdInInsurances < ActiveRecord::Migration[5.2]
  def change
    rename_column :insurances, :company_id, :vendor_id
  end
end
