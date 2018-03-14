class CreateInsurances < ActiveRecord::Migration[5.1]
  def change
    create_table :insurances do |t|
      t.datetime :date_of_issue
      t.decimal :total
      t.string :at_the_expense_of
      t.string :serial_of_contract
      t.string :description
      t.integer :recurrence
      t.datetime :deadline
      t.timestamps null: true

      t.references :user, foreign_key: true
      t.references :vehicle, foreign_key: true
      t.references :company, foreign_key: true
      t.references :category, foreign_key: true
    end
  end
end
