class AddAtTheExpenseOfColumnToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :at_the_expense_of, :string
  end
end
