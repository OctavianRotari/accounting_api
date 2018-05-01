class CreateJoinTableLineItemFuelReceipt < ActiveRecord::Migration[5.2]
  def change
    create_join_table :line_items, :fuel_receipts do |t|
      # t.index [:line_item_id, :fuel_receipt_id]
      # t.index [:fuel_receipt_id, :line_item_id]
    end
  end
end
