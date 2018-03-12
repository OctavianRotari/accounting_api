class AddCategoryIdToInvoice < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :category_id, :integer
  end
end
