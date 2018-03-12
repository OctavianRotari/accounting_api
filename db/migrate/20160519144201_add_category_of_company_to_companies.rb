class AddCategoryOfCompanyToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_reference :companies, :category_of_company, index: true, foreign_key: true
  end
end
