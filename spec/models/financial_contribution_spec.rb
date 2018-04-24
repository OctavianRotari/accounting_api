require 'rails_helper'

RSpec.describe FinancialContribution, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:contribution_type) }

  describe 'user creates a financial contribution' do
    it 'fails if there is no desc or total or date' do
      financial_contribution = build(:financial_contribution, desc: nil, total: nil, date: nil)
      financial_contribution.save
      expect(financial_contribution.errors.full_messages).to eq(["Desc required", "Total required", "Date required"])
    end

    describe 'record created successfully' do
      let (:user) { create(:user) }
      let(:contribution1) {create(:financial_contribution, user_id: user.id)}
      let(:contribution2) {create(:financial_contribution, user_id: user.id)}

      before :each do
        user
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
