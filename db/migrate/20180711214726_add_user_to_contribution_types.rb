class AddUserToContributionTypes < ActiveRecord::Migration[5.2]
  def change
    add_reference :contribution_types, :user, foreign_key: true
  end
end
