class AddLitresToFuelReceipts < ActiveRecord::Migration[5.1]
  def change
    add_column :fuel_receipts, :litres, :integer
  end
end
