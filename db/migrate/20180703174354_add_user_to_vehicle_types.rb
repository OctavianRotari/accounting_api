class AddUserToVehicleTypes < ActiveRecord::Migration[5.2]
  def change
    add_reference :vehicle_types, :user, foreign_key: true
  end
end
