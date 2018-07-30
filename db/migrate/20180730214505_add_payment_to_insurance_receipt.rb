class AddPaymentToInsuranceReceipt < ActiveRecord::Migration[5.2]
  def change
    add_reference :insurance_receipts, :payment, foreign_key: true
  end
end
