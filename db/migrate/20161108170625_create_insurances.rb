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
    end
  end
end
