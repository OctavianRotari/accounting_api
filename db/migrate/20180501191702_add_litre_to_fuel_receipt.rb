class AddLitreToFuelReceipt < ActiveRecord::Migration[5.2]
  def change
    add_column :fuel_receipts, :litres, :decimal, default: 0
  end
end
