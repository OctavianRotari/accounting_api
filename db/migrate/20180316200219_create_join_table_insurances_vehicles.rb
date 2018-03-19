class CreateJoinTableInsurancesVehicles < ActiveRecord::Migration[5.2]
  def change
    create_join_table :insurances, :vehicles do |t|
      t.index [:insurance_id, :vehicle_id]
    end
  end
end
