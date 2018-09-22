require 'rails_helper'

RSpec.describe FuelReceipt, type: :model do
  it { should belong_to(:vendor) }
  it { should belong_to(:vehicle) }

  it { should have_one(:line_item_to_fuel_receipt) }

  describe 'is created' do
    let (:user) { User.first }

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

  describe 'line item to fuel_receipt' do
    before :each do
      create(:invoice, :fuel_receipts)
    end

    it 'return fuel receipt' do
      fuel_receipt = FuelReceipt.first
      expect(fuel_receipt.line_item).to eq(LineItem.last)
    end

    it 'updates success' do
      create(:invoice, :fuel_receipts)
      fuel_receipt_params = {
        'total': 300.0,
        'litres': 400,
      }
      fuel_receipt = FuelReceipt.first
      expect(fuel_receipt.update(fuel_receipt_params)).to eq(true)
      line_item = fuel_receipt.line_item
      expect(line_item[:total]).to eq(300.0)
      expect(line_item[:quantity]).to eq(400)
    end
  end
end
