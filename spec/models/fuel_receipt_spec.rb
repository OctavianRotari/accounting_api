require 'rails_helper'

RSpec.describe FuelReceipt, type: :model do
  it { should belong_to(:vendor) }
  it { should belong_to(:vehicle) }

  it { should have_and_belong_to_many(:line_item) }

  describe 'is created' do
    let(:user) { create(:user) }

    before :each do
      @user = user
      vehicle_type = create(:vehicle_type, user_id: user.id)
      @vehicle = create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: @user.id)
      @vendor = create(:vendor, user_id: @user.id)
    end

    it 'total all fuel receipts' do
      create(:fuel_receipt, vehicle_id: @vehicle.id, vendor_id: @vendor.id)
      create(:fuel_receipt, vehicle_id: @vehicle.id, vendor_id: @vendor.id)
      expect(@vehicle.fuel_receipts.total).to eq(460.0)
    end
  end
end
