class RemoveUserIdFromActiveInvoices < ActiveRecord::Migration[5.2]
  def change
    remove_column :active_invoices, :user_id, :bigint
  end
end
