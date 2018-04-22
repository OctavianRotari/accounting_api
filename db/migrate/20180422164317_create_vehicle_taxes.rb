class CreateVehicleTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicle_taxes do |t|
      t.references :vehicle, foreign_key: true
      t.date :date
      t.date :deadline
      t.decimal :total
    end
  end
end
