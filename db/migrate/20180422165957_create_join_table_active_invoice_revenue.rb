class CreateJoinTableActiveInvoiceRevenue < ActiveRecord::Migration[5.2]
  def change
    create_join_table :active_invoices, :revenues do |t|
      # t.index [:active_invoice_id, :revenue_id]
      # t.index [:revenue_id, :active_invoice_id]
    end
  end
end
