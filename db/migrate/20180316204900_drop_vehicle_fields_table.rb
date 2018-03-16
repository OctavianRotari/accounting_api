class DropVehicleFieldsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :vehicle_fields
  end
end
