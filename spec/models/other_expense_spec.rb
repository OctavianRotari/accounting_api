require 'rails_helper'

RSpec.describe OtherExpense, type: :model do
  it { should belong_to(:user) }

  describe 'user creates a other expense' do
    it 'fails if there is no desc or total or date' do
      other_expense = build(:other_expense, desc: nil, total: nil, date: nil)
      other_expense.save
      expect(other_expense.errors.full_messages).to eq(["Desc required", "Total required", "Date required"])
    end

    describe 'record created successfully' do
      let (:user) { create(:user) }

      before :each do
        user
        create(:other_expense, user_id: user.id)
        create(:other_expense, user_id: user.id)
      end

      it 'returns the total of all recors' do
        expect(user.other_expenses.total).to eq(20.6)
      end
    end
  end
end
