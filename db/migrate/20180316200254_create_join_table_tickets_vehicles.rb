class CreateJoinTableTicketsVehicles < ActiveRecord::Migration[5.2]
  def change
    create_join_table :tickets, :vehicles do |t|
      t.index [:ticket_id, :vehicle_id]
    end
  end
end
