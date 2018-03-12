class RenameCategoryOfCompanyToCategory < ActiveRecord::Migration[5.1]
  def self.up
    rename_table :category_of_companies, :categories
  end
  def self.down
    rename_table :categories, :category_of_companies
  end
end
