class CreateSoldLineItemToLoad < ActiveRecord::Migration[5.2]
  def change
    create_table :sold_line_item_to_loads do |t|
      t.references :sold_line_item, foreign_key: true
      t.references :load, foreign_key: true
    end
  end
end
