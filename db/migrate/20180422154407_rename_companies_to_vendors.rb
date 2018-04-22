class RenameCompaniesToVendors < ActiveRecord::Migration[5.2]
  def change
    rename_table :companies, :vendors
  end
end
