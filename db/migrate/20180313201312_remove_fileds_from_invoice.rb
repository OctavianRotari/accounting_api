class RemoveFiledsFromInvoice < ActiveRecord::Migration[5.2]
  def change
    change_table(:invoices) do |t|
      t.remove :company_id
      t.remove :vehicle_id
      t.remove :category_id
      t.remove :total
    end
  end
end
