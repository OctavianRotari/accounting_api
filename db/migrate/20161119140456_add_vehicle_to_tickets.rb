class AddVehicleToTickets < ActiveRecord::Migration[5.1]
  def change
    add_reference :tickets, :vehicle, index: true, foreign_key: true
  end
end
