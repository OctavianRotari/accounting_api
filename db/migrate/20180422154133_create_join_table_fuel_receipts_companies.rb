class CreateJoinTableFuelReceiptsCompanies < ActiveRecord::Migration[5.2]
  def change
    create_join_table :fuel_receipts, :companies do |t|
      # t.index [:fuel_receipt_id, :companie_id]
      # t.index [:companie_id, :fuel_receipt_id]
    end
  end
end
