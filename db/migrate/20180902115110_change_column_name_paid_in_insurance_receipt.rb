class ChangeColumnNamePaidInInsuranceReceipt < ActiveRecord::Migration[5.2]
  def change
    rename_column :insurance_receipts, :paid, :total
    rename_column :insurance_receipts, :payment_date, :date
  end
end
