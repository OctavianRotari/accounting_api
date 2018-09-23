require 'rails_helper'

RSpec.describe Vendor, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:invoices) }
  it { should have_many(:fuel_receipts) }
  it { should have_many(:insurances) }
  it { should have_many(:active_invoices) }
  it { should have_many(:credit_notes) }

  describe 'user create a vendor' do
    before :each do
      if(User.all.count == 0)
        @user = create(:user)
      else
        @user = User.find_by(uid: 'octavianrotari@example.com')
      end
    end

    it 'fails if there is no user id' do
      vendor = build(:vendor, user_id: nil)
      vendor.save
      expect(vendor.errors.full_messages).to eq(["User must exist"])
    end

    it 'fails if there is no name, address or number' do
      vendor = build(:vendor, name: '', number: '', address: '')
      vendor.save
      expect(vendor.errors.full_messages).to eq(
        [
          "User must exist", 
          "Name required", 
          "Address required", 
          "Number required"
        ]
      )
    end

    it 'does not return others users vendors' do
      user_two = create(:user, email: 'test@test.com')
      vendor_two = build(:vendor, user_id: user_two.id)
      vendor_two.save
      expect(user_two.vendors).to eq([vendor_two])
    end
  end
end
