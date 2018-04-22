class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :surname
      t.date :contract_start_date
      t.date :contract_end_date
      t.string :role
      t.references :user, foreign_key: true
    end
  end
end
