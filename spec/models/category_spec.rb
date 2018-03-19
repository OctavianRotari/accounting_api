require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:companies) }

  describe 'user creates a category' do
    let(:user) { create(:user) }

    before :each do
      user
    end

    it 'fails if category name is not present and returns error' do
      category = build(:category, name: '')
      category.save
      expect(category.errors.full_messages).to eq(["Name required"])
      expect(user.categories).to eq([])
    end

    it 'creates a category successfully' do
      category = build(:category, name: 'Car shop', user_id: user.id)
      category.save
      expect(user.categories).to eq([category])
    end

    it 'does not return others users categories' do
      userTwo = create(:user, email: 'test@test.com')
      category = build(:category, name: 'Restaurants', user_id: userTwo.id)
      category.save
      expect(user.categories).to eq([])
    end
  end
end
