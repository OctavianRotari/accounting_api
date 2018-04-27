require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:fuel_receipts) }
  it { should have_many(:vehicle_taxes) }
  it { should have_many(:maintenances) }
  it { should have_many(:loads) }
  it { should belong_to(:vehicle_type) }

  it { should have_and_belong_to_many(:invoices) }
  it { should have_and_belong_to_many(:insurances) }
  it { should have_and_belong_to_many(:sanctions) }

  describe 'is created' do
    it 'fails if there is no desc or total or date' do
      vehicle = build(:vehicle, plate: nil, roadworthiness_check_date: nil, vehicle_type_id: nil)
      vehicle.save
      expect(vehicle.errors.full_messages).to eq(["Vehicle type must exist", "Roadworthiness check date required", "Plate required"])
    end

    describe 'fuel receipts' do
      let(:user) { create(:user) }

      before :each do
        @user = user
        @vehicle = create(:vehicle, user_id: @user.id)
        @vendor = create(:vendor, user_id: @user.id)
      end

      it 'total all fuel receipts' do
        create(:fuel_receipt, vehicle_id: @vehicle.id, vendor_id: @vendor.id)
        create(:fuel_receipt, vehicle_id: @vehicle.id, vendor_id: @vendor.id)
        expect(@vehicle.fuel_receipts_total).to eq(21)
      end
    end
  end
end
