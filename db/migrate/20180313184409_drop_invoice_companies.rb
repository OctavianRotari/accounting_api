class DropInvoiceCompanies < ActiveRecord::Migration[5.2]
  def change
    drop_table :invoice_companies
  end
end
