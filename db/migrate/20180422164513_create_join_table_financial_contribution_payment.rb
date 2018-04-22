class CreateJoinTableFinancialContributionPayment < ActiveRecord::Migration[5.2]
  def change
    create_join_table :financial_contributions, :payments do |t|
      # t.index [:financial_contribution_id, :payment_id]
      # t.index [:payment_id, :financial_contribution_id]
    end
  end
end
