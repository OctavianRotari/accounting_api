require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should belong_to(:user) }

  describe 'category' do
    let(:user) { create(:user) }

    before :each do
      user
    end

    it 'returns error if name not supplied' do
      category = build(:category, name: '')
      category.save
      expect(category.errors.full_messages).to eq(['Name required'])
    end

    it 'returns the created category' do
      category = create(:category, name: 'CarShop', user_id: user.id)
      expect(Category.all).to eq([category])
    end
  end
end
