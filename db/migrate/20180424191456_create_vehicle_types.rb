class CreateVehicleTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicle_types do |t|
      t.string :desc

      t.timestamps
    end
  end
end
