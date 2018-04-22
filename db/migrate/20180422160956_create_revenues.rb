class CreateRevenues < ActiveRecord::Migration[5.2]
  def change
    create_table :revenues do |t|
      t.decimal :total
      t.date :date
      t.string :method_of_payment
    end
  end
end
