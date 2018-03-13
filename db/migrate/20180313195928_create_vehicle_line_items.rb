class CreateVehicleLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicle_line_items do |t|
      t.references :vehicle, foreign_key: true
      t.references :invoice, foreign_key: true
      t.decimal :total

      t.timestamps
    end
  end
end
