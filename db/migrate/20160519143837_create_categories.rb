class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :gas_station
      t.integer :type_of

      t.timestamps null: true
    end
  end
end
