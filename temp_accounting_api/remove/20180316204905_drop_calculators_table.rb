class DropCalculatorsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :calculators
  end
end
