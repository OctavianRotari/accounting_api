class RemoveColumnsFromTicket < ActiveRecord::Migration[5.2]
  def change
    remove_column :tickets, :type_of, :integer
    remove_column :tickets, :vehicle_id, :integer
  end
end
