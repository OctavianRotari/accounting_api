class CreateJoinTableInvoicesVehicles < ActiveRecord::Migration[5.2]
  def change
    create_join_table :invoices, :vehicles do |t|
      t.index [:invoice_id, :vehicle_id]
      t.decimal :total
    end
  end
end
