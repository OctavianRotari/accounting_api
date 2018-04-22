class CreateFinancialContributions < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_contributions do |t|
      t.string :type
      t.date :date
      t.decimal :total
      t.references :user, foreign_key: true
    end
  end
end
