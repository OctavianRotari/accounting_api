class CreateJoinTableActiveInvoicesPayments < ActiveRecord::Migration[5.2]
  def change
    create_join_table :active_invoices, :payments do |t|
      t.index [:active_invoice_id, :payment_id], name: :receipts_payments
      # t.index [:payment_id, :active_invoice_id]
    end
  end
end
