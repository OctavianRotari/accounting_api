class RemoveGasStationFromCategory < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :gas_station, :boolean
  end
end
