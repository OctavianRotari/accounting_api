class AddDescriptionToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :description, :string
  end
end
