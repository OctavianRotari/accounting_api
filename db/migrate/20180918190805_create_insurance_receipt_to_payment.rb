class CreateInsuranceReceiptToPayment < ActiveRecord::Migration[5.2]
  def change
    create_table :insurance_receipt_to_payments do |t|
      t.references :insurance_receipt, foreign_key: true
      t.references :payment, foreign_key: true
    end
  end
end
