class AddTypeOfToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :type_of, :integer
  end
end
