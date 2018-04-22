class CreateOtherExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :other_expenses do |t|
      t.string :desc
      t.decimal :total
      t.date :date
      t.references :user, foreign_key: true
    end
  end
end
