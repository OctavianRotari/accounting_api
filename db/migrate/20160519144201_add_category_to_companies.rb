class AddCategoryToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_reference :companies, :category, index: true, foreign_key: true
  end
end
