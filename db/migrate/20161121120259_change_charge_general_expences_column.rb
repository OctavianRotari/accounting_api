class ChangeChargeGeneralExpencesColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :vehicles, :charge_general_expences, :charge_general_expenses
  end
end
