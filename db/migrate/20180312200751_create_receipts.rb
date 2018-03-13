class CreateReceipts < ActiveRecord::Migration[5.2]
  def change
    create_table :receipts do |t|
      t.datetime :data_of_issue
      t.datetime :deadline
      t.string :description
      t.boolean :collected
      t.string :serial_number

      t.timestamps
    end
  end
end
