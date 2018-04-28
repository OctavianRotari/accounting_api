class ChangeColumnNamePayments < ActiveRecord::Migration[5.2]
  def change
    rename_column :payments, :payment_date, :date
    rename_column :payments, :paid, :total
  end
end
