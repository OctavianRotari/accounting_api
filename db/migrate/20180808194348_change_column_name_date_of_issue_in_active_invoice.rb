class ChangeColumnNameDateOfIssueInActiveInvoice < ActiveRecord::Migration[5.2]
  def change
    rename_column :active_invoices, :date_of_issue, :date
  end
end
