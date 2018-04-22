class CreateJoinTableSanctionVehicle < ActiveRecord::Migration[5.2]
  def change
    create_join_table :sanctions, :vehicles do |t|
      # t.index [:sanction_id, :vehicle_id]
      # t.index [:vehicle_id, :sanction_id]
    end
  end
end
