require 'rails_helper'

RSpec.describe FinancialContribution, type: :model do
  it { should belong_to(:user) }

  describe 'user creates a financial contribution' do
    let (:user) { create(:user) }

    before :each do
      user
    end

    it 'fails if there is no user id' do
      financial_contribution = build(:financial_contribution, user_id: nil)
      financial_contribution.save
      expect(financial_contribution.errors.full_messages).to eq(["User must exist"])
    end

    it 'fails if there is no desc or total or date' do
      financial_contribution = build(:financial_contribution, user_id: user.id, desc: nil, total: nil, date: nil)
      financial_contribution.save
      expect(financial_contribution.errors.full_messages).to eq(["Desc required", "Total required", "Date required"])
    end

    it 'does note return other users' do
      user_two = create(:user, email: 'test@test.com')
      financial_contribution_two = build(:financial_contribution, user_id: user_two.id)
      financial_contribution_two.save
      expect(user.financial_contributions).to eq([])
      expect(user_two.financial_contributions).to eq([financial_contribution_two])
    end
  end
end
