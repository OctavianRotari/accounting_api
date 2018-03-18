class RemoveColumnsFromInvoice < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoices, :type_of_invoice, :string
    remove_column :invoices, :at_the_expense_of, :string
    remove_column :invoices, :total_taxable, :decimal
    remove_column :invoices, :total_vat, :decimal
    remove_column :invoices, :vehicle_id, :integer
    remove_column :invoices, :total, :decimal
    remove_column :invoices, :company_id, :integer
    remove_column :invoices, :category_id, :integer
  end
end
