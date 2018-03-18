class ChangeColumnTypeToDecimal < ActiveRecord::Migration[5.2]
  def change
    change_column :tickets, :total, :decimal
  end
end
