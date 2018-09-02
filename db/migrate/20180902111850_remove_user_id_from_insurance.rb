class RemoveUserIdFromInsurance < ActiveRecord::Migration[5.2]
  def change
    remove_column :insurances, :user_id, :reference
  end
end
