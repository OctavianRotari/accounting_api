class CreateSoldLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :sold_line_items do |t|
      t.integer :vat
      t.decimal :amount
      t.string :description
      t.integer :quantity, default: 1
      t.references :active_invoice, foreign_key: true

      t.timestamps
    end
  end
end
