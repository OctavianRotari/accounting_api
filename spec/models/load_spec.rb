require 'rails_helper'

RSpec.describe Load, type: :model do
  it { should belong_to(:vendor) }
  it { should belong_to(:vehicle) }

  it { should have_one(:sold_line_item_to_load) }

  describe 'is created' do
    let (:user) { User.first }

    before :each do
      @user = user
      vehicle_type = create(:vehicle_type, user_id: user.id)
      @vehicle = create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: @user.id)
      @vendor = create(:vendor, user_id: @user.id)
    end

    it 'total all loads' do
      create(:load, vehicle_id: @vehicle.id, vendor_id: @vendor.id)
      create(:load, vehicle_id: @vehicle.id, vendor_id: @vendor.id)
      expect(@vehicle.loads.total).to eq(600.4)
    end
  end

  describe 'line item to fuel_receipt' do
    before :each do
      create(:active_invoice, :loads)
    end

    it 'return fuel receipt' do
      load = Load.first
      expect(load.sold_line_item).to eq(SoldLineItem.first)
    end

    it 'updates success' do
      create(:active_invoice, :loads)
      load_params = {
        'total': 300.0,
      }
      load = Load.first
      expect(load.update(load_params)).to eq(true)
      sold_line_item = load.sold_line_item
      expect(sold_line_item[:total]).to eq(300.0)
      expect(sold_line_item[:description]).to eq("Ravenna, via dell'abbondanza 7 - Milano, via giorgino 8: Metallo")
    end
  end
end
