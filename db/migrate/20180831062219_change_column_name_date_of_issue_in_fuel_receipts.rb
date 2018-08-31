class ChangeColumnNameDateOfIssueInFuelReceipts < ActiveRecord::Migration[5.2]
  def change
    rename_column :fuel_receipts, :date_of_issue, :date
  end
end
