class AddInsuranceToReceipts < ActiveRecord::Migration[5.1]
  def change
    add_reference :receipts, :insurance, index: true, foreign_key: true
  end
end
