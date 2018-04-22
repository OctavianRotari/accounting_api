class CreateJoinTableLoadActiveInvoice < ActiveRecord::Migration[5.2]
  def change
    create_join_table :loads, :active_invoices do |t|
      # t.index [:load_id, :active_invoice_id]
      # t.index [:active_invoice_id, :load_id]
    end
  end
end
