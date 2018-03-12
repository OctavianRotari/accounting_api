class ChangeNames < ActiveRecord::Migration[5.1]
  def change
    rename_column :invoices, :date, :date_of_issue
    rename_column :payments, :date, :payment_date
  end
end
