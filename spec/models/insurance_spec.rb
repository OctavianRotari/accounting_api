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
        "Date required", 
        "Deadline required", 
        "Description required", 
        "Total required", 
        "Serial of contract required", 
        "Payment recurrence required"
      ])
    end
  end

  describe 'create insurance with vehicle' do
    before :all do
      @vendor = create(:vendor)
      @insurance = attributes_for(:insurance, :valid, vendor_id: @vendor.id, total: 4000.0)
      @vehicle = create(:vehicle)
    end

    it 'error no vehicle_id' do
      expect(Insurance.vehicle(@insurance).message).to eq("Couldn't find Vehicle without an ID")
    end

    it 'success' do
      @insurance[:vehicle_id] = @vehicle.id
      Insurance.vehicle(@insurance)
      expect(@vehicle.insurances).to eq([Insurance.last])
    end

    it 'error multiple insurance for vehicle' do
      insurance_1 = attributes_for(:insurance, :valid, vendor_id: @vendor.id)
      @insurance[:vehicle_id] = @vehicle.id
      Insurance.vehicle(@insurance)
      insurance_1[:vehicle_id] = @vehicle.id
      expect(Insurance.vehicle(insurance_1)).to eq(
        'A vehicle cannot have more than one active insurance.'
      )
    end
  end
end
