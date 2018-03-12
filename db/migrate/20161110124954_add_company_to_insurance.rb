class AddCompanyToInsurance < ActiveRecord::Migration[5.1]
  def change
    add_reference :insurances, :company, index: true, foreign_key: true
  end
end
