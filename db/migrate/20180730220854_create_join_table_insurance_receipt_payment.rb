class CreateJoinTableInsuranceReceiptPayment < ActiveRecord::Migration[5.2]
  def change
    create_join_table :insurance_receipts, :payments do |t|
      # t.index [:insurance_receipt_id, :payment_id]
      # t.index [:payment_id, :insurance_receipt_id]
    end
  end
end
