class RemoveCollectedFromActiveInvoice < ActiveRecord::Migration[5.2]
  def change
    remove_column :active_invoices, :collected, :boolean
  end
end
