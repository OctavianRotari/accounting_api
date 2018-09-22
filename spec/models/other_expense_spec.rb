require 'rails_helper'

RSpec.describe OtherExpense, type: :model do
  it { should belong_to(:user) }

  describe 'create' do
    it 'fails if there is no desc or total or date' do
      other_expense = build(:other_expense, desc: nil, total: nil, date: nil)
      other_expense.save
      expect(other_expense.errors.full_messages).to eq(["User must exist", "Desc required", "Total required", "Date required"])
    end

    describe 'record created successfully' do
      before :each do
        create(:other_expense)
        create(:other_expense)
        user = attributes_for(:user)
        @user = User.find_by(uid: user[:email])
      end

      it 'returns the total of all recors' do
        expect(@user.other_expenses.total).to eq(20.6)
      end

      it 'returns payd the total of all recors' do
        expect(@user.other_expenses.total_paid).to eq(20.6)
      end
    end
  end
end
