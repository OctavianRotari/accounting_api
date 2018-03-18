class DropGaragesTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :garages
  end
end
