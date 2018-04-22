class CreateSanctions < ActiveRecord::Migration[5.2]
  def change
    create_table :sanctions do |t|
      t.references :user, foreign_key: true
      t.decimal :total
      t.date :date
      t.date :deadline
      t.string :description
    end
  end
end
