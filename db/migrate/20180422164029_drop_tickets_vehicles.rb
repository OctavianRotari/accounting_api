class DropTicketsVehicles < ActiveRecord::Migration[5.2]
  def change
    drop_table :tickets_vehicles
  end
end
