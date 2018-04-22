class CreateJoinTabkeFuelReceiptsCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :join_tabke_fuel_receipts_companies do |t|
      t.string :fuel_receipts
      t.string :companies
    end
  end
end
