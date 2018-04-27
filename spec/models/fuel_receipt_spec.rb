require 'rails_helper'

RSpec.describe FuelReceipt, type: :model do
  it { should belong_to(:vendor) }
  it { should belong_to(:vehicle) }

  it { should have_and_belong_to_many(:invoices) }

  describe 'is created' do
    let(:user) { create(:user) }

    before :each do
      @user = user
      @vehicle = create(:vehicle, user_id: @user.id)
      @vendor = create(:vendor, user_id: @user.id)
    end

    it 'total all fuel receipts' do
      create(:fuel_receipt, vehicle_id: @vehicle.id, vendor_id: @vendor.id)
      create(:fuel_receipt, vehicle_id: @vehicle.id, vendor_id: @vendor.id)
      expect(@vehicle.fuel_receipts.total).to eq(460.0)
    end
  end
end
