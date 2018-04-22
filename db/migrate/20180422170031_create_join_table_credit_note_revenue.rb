class CreateJoinTableCreditNoteRevenue < ActiveRecord::Migration[5.2]
  def change
    create_join_table :credit_notes, :revenues do |t|
      # t.index [:credit_note_id, :revenue_id]
      # t.index [:revenue_id, :credit_note_id]
    end
  end
end
