class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.integer :total
      t.integer :type_of
      t.datetime :date_of_issue
      t.datetime :deadline
      t.timestamps null: true
    end

    add_reference :tickets, :user, index: true, foreign_key: true
  end
end
