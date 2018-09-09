class CreateLineItemToFuelReceipts < ActiveRecord::Migration[5.2]
  def change
    create_table :line_item_to_fuel_receipts do |t|
      t.references :line_item, foreign_key: true
      t.references :fuel_receipt, foreign_key: true

      t.timestamps
    end
  end
end
