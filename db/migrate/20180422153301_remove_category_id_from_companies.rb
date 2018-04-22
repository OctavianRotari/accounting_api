class RemoveCategoryIdFromCompanies < ActiveRecord::Migration[5.2]
  def change
    remove_column :companies, :category_id, :bigint
  end
end
