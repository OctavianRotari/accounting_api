require 'rails_helper'

RSpec.describe Insurance, type: :model do
  it { should belong_to(:vendor) }
  it { should have_and_belong_to_many(:vehicles) }
  it { should have_many(:insurance_receipts) }

  describe 'create' do
    it 'fails if there is no filled fields' do
      insurance = build(:insurance, :invalid)
      insurance.save
      expect(insurance.errors.full_messages).to eq([
        "Vendor must exist", 
        "Date required", 
        "Deadline required", 
        "Description required", 
        "Total required", 
        "Serial of contract required", 
        "Payment recurrence required"
      ])
    end

    describe 'create insurance with vehicle' do
      before :each do
        user = create(:user)
        @vendor = create(:vendor, user_id: user.id)
        vehicle_type = create(:vehicle_type, user_id: user.id)
        @insurance = attributes_for(:insurance, :valid, vendor_id: @vendor.id)
        @vehicle = create(:vehicle, user_id: user.id, vehicle_type_id: vehicle_type.id)
      end

      it 'error no vehicle_id' do
        expect(Insurance.vehicle_new(@insurance).message).to eq("Couldn't find Vehicle without an ID")
      end

      it 'success' do
        @insurance[:vehicle_id] = @vehicle.id
        Insurance.vehicle_new(@insurance)
        expect(Insurance.all.length).to eq(1)
        expect(@vehicle.insurances).to eq(Insurance.all)
      end

      it 'error multiple insurance for vehicle' do
        insurance_1 = attributes_for(:insurance, :valid, vendor_id: @vendor.id)
        @insurance[:vehicle_id] = @vehicle.id
        Insurance.vehicle_new(@insurance)
        insurance_1[:vehicle_id] = @vehicle.id
        expect(Insurance.vehicle_new(insurance_1)).to eq(
          'A vehicle cannot have more than one active insurance.'
        )
      end
    end
  end
end
