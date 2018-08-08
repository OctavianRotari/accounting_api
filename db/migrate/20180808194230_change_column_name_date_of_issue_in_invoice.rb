class ChangeColumnNameDateOfIssueInInvoice < ActiveRecord::Migration[5.2]
  def change
    rename_column :invoices, :date_of_issue, :date
  end
end
