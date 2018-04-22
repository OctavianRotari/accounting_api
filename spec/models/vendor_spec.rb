require 'rails_helper'

RSpec.describe Vendor, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:insurances) }
  it { should have_many(:invoices) }

  describe 'user create a vendor' do
    let(:user) { create(:user) }

    before :each do
      user
    end

    it 'fails if there is no user id' do
      vendor = build(:vendor, user_id: nil)
      vendor.save
      expect(vendor.errors.full_messages).to eq(["User must exist"])
    end

    it 'fails if there is no name, adress or number' do
      vendor = build(:vendor, name: '', number: '', adress: '', user_id: user.id)
      vendor.save
      expect(vendor.errors.full_messages).to eq(["Name required", "Adress required", "Number required"])
    end

    it 'does not return others users companies' do
      userTwo = create(:user, email: 'test@test.com')
      vendorTwo = build(:vendor, user_id: userTwo.id)
      vendorTwo.save
      expect(user.vendors).to eq([])
      expect(userTwo.vendors).to eq([vendorTwo])
    end
  end
end
