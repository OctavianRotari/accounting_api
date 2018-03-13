class DropCompanyInvoice < ActiveRecord::Migration[5.2]
  def change
    drop_table :company_invoice
  end
end
