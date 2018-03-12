class AddChargeGeneralExpencesToVehicles < ActiveRecord::Migration[5.1]
  def change
    add_column :vehicles, :charge_general_expences, :boolean, default: false
  end
end
