class AddTotalToSoldLineItem < ActiveRecord::Migration[5.2]
  def change
    add_column :sold_line_items, :total, :decimal
  end
end
