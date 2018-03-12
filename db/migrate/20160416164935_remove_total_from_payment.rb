class RemoveTotalFromPayment < ActiveRecord::Migration[5.1]
  def change
    remove_column :payments, :total, :decimal
  end
end
