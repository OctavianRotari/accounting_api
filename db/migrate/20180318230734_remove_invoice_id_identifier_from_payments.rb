class RemoveInvoiceIdIdentifierFromPayments < ActiveRecord::Migration[5.2]
  def change
    remove_column :payments, :invoice_id_identifier, :integer
  end
end
