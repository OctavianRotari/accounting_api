class ChangeColumnNameRecurrenceInsurance < ActiveRecord::Migration[5.2]
  def change
    rename_column :insurances, :recurrence, :payment_recurrence
  end
end
