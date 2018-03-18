class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.integer :total
      t.integer :type_of
      t.datetime :date_of_issue
      t.datetime :deadline
      t.boolean :paid
      t.string :description
      t.references :user, foreign_key: true
      t.references :vehicle, foreign_key: true

      t.timestamps null: true
    end
  end
end
