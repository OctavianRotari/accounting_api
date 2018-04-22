class CreateJoinTableVehicleTaxPayment < ActiveRecord::Migration[5.2]
  def change
    create_join_table :vehicle_taxes, :payments do |t|
      # t.index [:vehicle_tax_id, :payment_id]
      # t.index [:payment_id, :vehicle_tax_id]
    end
  end
end
