class CreateCreditNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_notes do |t|
      t.references :vendor, foreign_key: true
      t.date :date
      t.decimal :total
    end
  end
end
