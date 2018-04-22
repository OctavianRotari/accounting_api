class CreateJoinTableInvoiceFuelReceipt < ActiveRecord::Migration[5.2]
  def change
    create_join_table :invoices, :fuel_receipts do |t|
      # t.index [:invoice_id, :fuel_receipt_id]
      # t.index [:fuel_receipt_id, :invoice_id]
    end
  end
end
