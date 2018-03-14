class AddGeneralExpenceToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :general_expence, :boolean, default: false
  end
end
