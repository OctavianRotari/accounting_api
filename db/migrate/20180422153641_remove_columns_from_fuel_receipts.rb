class RemoveColumnsFromFuelReceipts < ActiveRecord::Migration[5.2]
  def change
    remove_column :fuel_receipts, :fuel_receipts, :integer
    remove_column :fuel_receipts, :company_id, :bigint
  end
end
