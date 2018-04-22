class DropTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :tickets
    drop_table :join_tabke_fuel_receipts_companies
  end
end
