class RemoveTableFuelReceiptsLineItems < ActiveRecord::Migration[5.2]
  def change
      drop_join_table :fuel_receipts, :line_items 
  end
end
