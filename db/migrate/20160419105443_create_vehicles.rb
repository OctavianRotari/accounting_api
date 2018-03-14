class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :plate
      t.string :type_of_vehicle
      t.boolean :charge_general_expenses, default: false 

      t.timestamps null: true
    end
  end
end
