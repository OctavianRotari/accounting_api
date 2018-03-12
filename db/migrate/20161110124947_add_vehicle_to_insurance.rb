class AddVehicleToInsurance < ActiveRecord::Migration[5.1]
  def change
    add_reference :insurances, :vehicle, index: true, foreign_key: true
  end
end
