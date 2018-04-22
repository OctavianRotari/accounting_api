class CreateJoinTableSalaryPayment < ActiveRecord::Migration[5.2]
  def change
    create_join_table :salaries, :payments do |t|
      # t.index [:salary_id, :payment_id]
      # t.index [:payment_id, :salary_id]
    end
  end
end
