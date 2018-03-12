class AddCategoryToInsurances < ActiveRecord::Migration[5.1]
  def change
    add_reference :insurances, :category, index: true
  end
end
