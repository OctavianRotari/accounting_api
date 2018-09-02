class ChangeColumnNameDateOfIssueInInsurance < ActiveRecord::Migration[5.2]
  def change
    rename_column :insurances, :date_of_issue, :date
  end
end
