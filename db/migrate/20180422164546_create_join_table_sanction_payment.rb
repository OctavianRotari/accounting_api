class CreateJoinTableSanctionPayment < ActiveRecord::Migration[5.2]
  def change
    create_join_table :sanctions, :payments do |t|
      # t.index [:sanction_id, :payment_id]
      # t.index [:payment_id, :sanction_id]
    end
  end
end
