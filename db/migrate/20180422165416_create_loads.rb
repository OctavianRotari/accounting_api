class CreateLoads < ActiveRecord::Migration[5.2]
  def change
    create_table :loads do |t|
      t.references :vehicle, foreign_key: true
      t.references :vendor, foreign_key: true
      t.string :from
      t.string :to
      t.string :serial_number
      t.integer :weight
      t.date :date
      t.string :desc
      t.decimal :price
    end
  end
end
