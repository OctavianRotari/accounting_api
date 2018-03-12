class ChangeSerialNumberColumnType < ActiveRecord::Migration[5.1]
  def change
    change_column :invoices, :serial_number, :string
  end
end
