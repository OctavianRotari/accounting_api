class RemovePlateFromInvoice < ActiveRecord::Migration[5.1]
  def change
    remove_column :invoices, :plate, :string
  end
end
