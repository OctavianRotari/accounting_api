class DropVehicleLineItems < ActiveRecord::Migration[5.2]
  def change
    drop_table :vehicle_line_items
  end
end
