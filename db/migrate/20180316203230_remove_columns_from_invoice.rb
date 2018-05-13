class RemoveColumnsFromInvoice < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoices, :type_of_invoice, :string
    remove_column :invoices, :at_the_expense_of, :string
    remove_column :invoices, :total_taxable, :decimal
    remove_column :invoices, :total_vat, :decimal
    remove_column :invoices, :vehicle_id, :integer
    remove_column :invoices, :total, :decimal
    remove_column :invoices, :category_id, :integer
    remove_column :invoices, :paid, :boolean
    remove_column :invoices, :user_id, :bigint
    remove_column :invoices, :general_expense, :boolean
  end
end
