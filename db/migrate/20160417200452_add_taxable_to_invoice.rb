class AddTaxableToInvoice < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :taxable, :decimal
  end
end
