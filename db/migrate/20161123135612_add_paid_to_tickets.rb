class AddPaidToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :paid, :boolean
  end
end
