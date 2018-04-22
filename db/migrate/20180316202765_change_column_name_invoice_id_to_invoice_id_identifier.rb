class ChangeColumnNameInvoiceIdToInvoiceIdIdentifier < ActiveRecord::Migration[5.2]
  def change
    rename_column :payments, :invoice_id, :invoice_id_identifier
  end
end
