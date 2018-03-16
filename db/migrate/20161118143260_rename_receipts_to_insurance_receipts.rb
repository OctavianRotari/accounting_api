class RenameReceiptsToInsuranceReceipts < ActiveRecord::Migration[5.1]
  def change
    rename_table :receipts, :insurance_receipts
  end
end
