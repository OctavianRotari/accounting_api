class AddReasonToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :reason, :string
  end
end
