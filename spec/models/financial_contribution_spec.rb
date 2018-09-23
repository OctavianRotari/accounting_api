require 'rails_helper'

RSpec.describe FinancialContribution, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:contribution_type) }
  it { should have_and_belong_to_many(:vehicles) }

  describe 'user creates a financial contribution' do
    it 'fails if there is no desc or total or date' do
      financial_contribution = build(:financial_contribution, desc: nil, total: nil, date: nil)
      financial_contribution.save
      expect(financial_contribution.errors.full_messages).to eq(
        [
          "User must exist", 
          "Desc required", 
          "Total required", 
          "Date required"
        ]
      )
    end

    describe 'record created successfully' do
      before :all do
        @constribution1 = create(:financial_contribution)
        @constribution2 = create(:financial_contribution, :type_two)
        user = attributes_for(:user)
        @user = User.find_by(uid: user[:email])
      end

      it 'returns the total of all recors' do
        expect(@user.financial_contributions.total).to eq(20.6)
      end

      it 'returns all records for the specified category' do
        contribution_factory = attributes_for(:financial_contribution)
        expect(@user.financial_contributions.where(contribution_type_id: contribution_factory[:contribution_type_id]).count).to eq(1)
      end

      it 'returns the total only for the specified category' do
        expect(@user.financial_contributions.calc_total_where(@constribution1.contribution_type.id)).to eq(10.3)
      end
    end
  end
end
