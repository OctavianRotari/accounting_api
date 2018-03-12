class AddTotalToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :total, :decimal
  end
end
