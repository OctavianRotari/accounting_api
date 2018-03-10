class RemoveTypeOfFromCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :type_of, :integer
  end
end
