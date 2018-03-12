class ChangeColumnNameCompany < ActiveRecord::Migration[5.1]
  def change
    rename_column :companies, :category_of_company_id, :category_id
  end
end
