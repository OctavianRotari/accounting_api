class ChangeReceiptsToInsuranceReceipts < ActiveRecord::Migration[5.2]
  def change
    rename_table :receipts, :insurance_receipts
  end
end
