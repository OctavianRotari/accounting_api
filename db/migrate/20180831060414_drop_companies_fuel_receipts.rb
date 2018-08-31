class DropCompaniesFuelReceipts < ActiveRecord::Migration[5.2]
  def up
    drop_table :companies_fuel_receipts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
