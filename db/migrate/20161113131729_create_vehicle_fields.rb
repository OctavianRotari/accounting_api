class CreateVehicleFields < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicle_fields do |t|
      t.integer :part_of_total
      t.timestamps null: true

      t.references :invoice, index: true, foreign_key: true
      t.references :vehicle, index: true, foreign_key: true
    end
  end
end
