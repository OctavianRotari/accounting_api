class AddTypeOfInvoiceToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :type_of_invoice, :string
  end
end
