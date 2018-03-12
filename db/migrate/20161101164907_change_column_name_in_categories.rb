class ChangeColumnNameInCategories < ActiveRecord::Migration[5.1]
  def change
    rename_column :categories, :category, :name
  end
end
