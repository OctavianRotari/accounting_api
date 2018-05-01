class CreateJoinTableLoadSoldLineItem < ActiveRecord::Migration[5.2]
  def change
    create_join_table :loads, :sold_line_items do |t|
      # t.index [:load_id, :sold_line_item_id]
      # t.index [:sold_line_item_id, :load_id]
    end
  end
end
