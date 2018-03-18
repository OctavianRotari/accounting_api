class AddGeneralExpenceToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :general_expense, :boolean, default: false
  end
end
