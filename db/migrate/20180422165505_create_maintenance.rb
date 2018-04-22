class CreateMaintenance < ActiveRecord::Migration[5.2]
  def change
    create_table :maintenances do |t|
      t.references :vehicle, foreign_key: true
      t.date :date
      t.date :deadline
      t.string :desc
      t.integer :km
    end
  end
end
