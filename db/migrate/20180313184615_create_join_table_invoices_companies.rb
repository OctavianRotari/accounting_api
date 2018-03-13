class CreateJoinTableInvoicesCompanies < ActiveRecord::Migration[5.2]
  def change
    create_join_table :invoices, :companies do |t|
      t.index [:invoice_id, :company_id]
      # t.index [:company_id, :invoice_id]
    end
  end
end
