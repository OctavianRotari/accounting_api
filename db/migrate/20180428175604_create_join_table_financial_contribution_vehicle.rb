class CreateJoinTableFinancialContributionVehicle < ActiveRecord::Migration[5.2]
  def change
    create_join_table :financial_contributions, :vehicles do |t|
      # t.index [:financial_contribution_id, :vehicle_id]
      # t.index [:vehicle_id, :financial_contribution_id]
    end
  end
end
