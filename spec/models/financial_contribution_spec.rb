require 'rails_helper'

RSpec.describe FinancialContribution, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:contribution_type) }

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

    describe 'record created successfully' do
      let(:contribution1) {create(:financial_contribution, user_id: user.id)}
      let(:contribution2) {create(:financial_contribution, user_id: user.id)}

      before :each do
        contribution1
        contribution2
        create(:financial_contribution, user_id: user.id, contribution_type_id: 2)
      end

      it 'returns the total of all recors' do
        expect(user.financial_contributions.total).to eq(30.9)
      end

      it 'returns all records for the specified category' do
        expect(user.financial_contributions.find_where(1)).to eq([contribution1, contribution2])
      end

      it 'returns the total only for the specified category' do
        expect(user.financial_contributions.calc_total_where(2)).to eq(10.3)
      end
    end
  end
end
