class ChangeColumnNamePriceToTotalInLoad < ActiveRecord::Migration[5.2]
  def change
    rename_column :loads, :price, :total
  end
end
