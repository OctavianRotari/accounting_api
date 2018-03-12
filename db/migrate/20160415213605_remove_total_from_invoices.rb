class RemoveTotalFromInvoices < ActiveRecord::Migration[5.1]
  def change
    remove_column :invoices, :total, :integer
  end
end
