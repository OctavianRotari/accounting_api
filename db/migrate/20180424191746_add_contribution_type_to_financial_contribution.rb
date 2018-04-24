class AddContributionTypeToFinancialContribution < ActiveRecord::Migration[5.2]
  def change
    add_reference :financial_contributions, :contribution_type, foreign_key: true
  end
end
