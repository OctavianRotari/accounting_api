class CreateContributionTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :contribution_types do |t|
      t.string :desc

      t.timestamps
    end
  end
end
