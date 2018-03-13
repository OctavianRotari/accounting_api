class RenameDataOfIssueToDateOfIssue < ActiveRecord::Migration[5.2]
  def change
    rename_column :receipts, :data_of_issue, :date_of_issue
  end
end
