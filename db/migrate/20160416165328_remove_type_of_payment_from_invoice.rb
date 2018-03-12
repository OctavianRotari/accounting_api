class RemoveTypeOfPaymentFromInvoice < ActiveRecord::Migration[5.1]
  def change
    remove_column :invoices, :type_of_payment, :string
  end
end
