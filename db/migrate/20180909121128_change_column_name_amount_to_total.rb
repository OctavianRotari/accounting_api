class ChangeColumnNameAmountToTotal < ActiveRecord::Migration[5.2]
  def change
    rename_column :line_items, :amount, :total
    rename_column :sold_line_items, :amount, :date
  end
end
