class CreateJoinTableInsurancesCompanies < ActiveRecord::Migration[5.2]
  def change
    create_join_table :insurances, :companies do |t|
      t.index [:insurance_id, :company_id]
      # t.index [:vehicle_id, :ticket_id]
    end
  end
end
