class AddCompanyToFuelReceipt < ActiveRecord::Migration[5.1]
  def change
    add_reference :fuel_receipts, :company, index: true, foreign_key: true
  end
end
