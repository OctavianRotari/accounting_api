class AddVehicleToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_reference :invoices, :vehicle, index: true, foreign_key: true
  end
end
