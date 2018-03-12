class CreateVehicleFields < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicle_fields do |t|
      t.integer :vehicle_id
      t.integer :part_of_total
      t.belongs_to :invoice, index: true, foreign_key: true
      t.timestamps null: true
    end
  end
end
