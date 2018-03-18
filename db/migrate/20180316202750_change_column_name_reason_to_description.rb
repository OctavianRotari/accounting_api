class ChangeColumnNameReasonToDescription < ActiveRecord::Migration[5.2]
  def change
    rename_column :invoices, :reason, :description
  end
end
