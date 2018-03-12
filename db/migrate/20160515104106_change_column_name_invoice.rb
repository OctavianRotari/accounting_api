class ChangeColumnNameInvoice < ActiveRecord::Migration[5.1]
  def change
    rename_column :invoices, :vat, :total_vat
    rename_column :invoices, :taxable, :total_taxable
  end
end
