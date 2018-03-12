class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :taxable_vat_fields, :vat, :vat_rate
  end
end
