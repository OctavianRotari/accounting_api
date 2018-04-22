class RemoveColumnsFromInsurance < ActiveRecord::Migration[5.2]
  def change
    remove_column :insurances, :vehicle_id, :integer
    remove_column :insurances, :at_the_expense_of, :string
    remove_column :insurances, :category_id, :integer
  end
end
