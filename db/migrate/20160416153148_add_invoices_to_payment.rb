class AddInvoicesToPayment < ActiveRecord::Migration[5.1]
  def change
    add_reference :payments, :invoice, index: true, foreign_key: true
  end
end
