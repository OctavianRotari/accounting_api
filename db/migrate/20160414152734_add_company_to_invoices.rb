class AddCompanyToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_reference :invoices, :company, index: true, foreign_key: true
  end
end
