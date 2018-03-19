class RemoveUserIdFromFuelReceipt < ActiveRecord::Migration[5.2]
  def change
    remove_column :fuel_receipts, :user_id, :integer
  end
end
