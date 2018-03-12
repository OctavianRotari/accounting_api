class AddPaidToPayment < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :paid, :decimal
  end
end
