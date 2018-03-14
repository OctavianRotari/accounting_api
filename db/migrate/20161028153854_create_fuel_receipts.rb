class CreateFuelReceipts < ActiveRecord::Migration[5.1]
  def change
    create_table :fuel_receipts do |t|
      t.decimal :total
      t.integer :fuel_receipts
      t.datetime :date_of_issue
      t.timestamps null: true

      t.references :vehicle, foreign_key: true
      t.references :company, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
