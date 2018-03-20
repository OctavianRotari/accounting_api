require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should belong_to(:category) }
  it { should have_and_belong_to_many(:insurances) }
  it { should have_and_belong_to_many(:invoices) }

  describe 'user create a company' do
    let(:user) { create(:user) }
    let(:category) { create(:category, user_id: user.id) }

    before :each do
      user
      category
    end

    it 'fails if there is no category id' do
      company = build(:company)
      company.save
      expect(company.errors.full_messages).to eq(["Category must exist"])
    end

    it 'fails if there is no name, adress or number' do
      company = build(:company, category_id: category.id, name: '', number: '', adress: '')
      company.save
      expect(company.errors.full_messages).to eq(["Name required", "Adress required", "Number required"])
    end

    it 'does not return others users companies' do
      userTwo = create(:user, email: 'test@test.com')
      categoryTwo = create(:category, name: 'Restaurants', user_id: userTwo.id)
      companyTwo = build(:company, category_id: categoryTwo.id)
      companyTwo.save
      expect(user.companies).to eq([])
      expect(userTwo.companies).to eq([companyTwo])
    end
  end
end
