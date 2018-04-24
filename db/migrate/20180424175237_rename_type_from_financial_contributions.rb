class RenameTypeFromFinancialContributions < ActiveRecord::Migration[5.2]
  def change
    rename_column :financial_contributions, :type, :desc
  end
end
