class ChangeColumnTypeFuelReceiptTotal < ActiveRecord::Migration[5.1]
  def change
    change_column :fuel_receipts, :total, :decimal
  end
end
