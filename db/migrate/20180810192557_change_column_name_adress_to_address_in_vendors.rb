class ChangeColumnNameAdressToAddressInVendors < ActiveRecord::Migration[5.2]
  def change
    rename_column :vendors, :adress, :address
  end
end
