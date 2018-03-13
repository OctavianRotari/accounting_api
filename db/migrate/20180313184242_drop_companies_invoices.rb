class DropCompaniesInvoices < ActiveRecord::Migration[5.2]
  def change
    drop_table :companies_invoices
  end
end
