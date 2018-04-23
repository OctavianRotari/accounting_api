require 'rails_helper'

RSpec.describe OtherExpense, type: :model do
  it { should belong_to(:user) }

  describe 'user creates a other expense' do
    let (:user) { create(:user) }

    before :each do
      user
    end

    it 'fails if there is no user id' do
      other_expense = build(:other_expense, user_id: nil)
      other_expense.save
      expect(other_expense.errors.full_messages).to eq(["User must exist"])
    end

    it 'fails if there is no desc or total or date' do
      other_expense = build(:other_expense, user_id: user.id, desc: nil, total: nil, date: nil)
      other_expense.save
      expect(other_expense.errors.full_messages).to eq(["Desc required", "Total required", "Date required"])
    end

    it 'does note return other users other expenses' do
      user_two = create(:user, email: 'test@test.com')
      other_expenses_two = build(:other_expense, user_id: user_two.id)
      other_expenses_two.save
      expect(user.other_expenses).to eq([])
      expect(user_two.other_expenses).to eq([other_expenses_two])
    end
  end
end
