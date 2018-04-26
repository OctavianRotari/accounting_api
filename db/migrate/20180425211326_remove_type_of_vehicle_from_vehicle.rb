class RemoveTypeOfVehicleFromVehicle < ActiveRecord::Migration[5.2]
  def change
    remove_column :vehicles, :type_of_vehicle, :string
  end
end
