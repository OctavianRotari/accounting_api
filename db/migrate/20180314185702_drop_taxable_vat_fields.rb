class DropTaxableVatFields < ActiveRecord::Migration[5.2]
  def change
    drop_table :taxable_vat_fields
  end
end
