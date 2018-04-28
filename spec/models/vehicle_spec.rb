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

    describe 'all maintenances deadlines' do
      before :each do
        @user = create(:user)
        @vehicle = create(:vehicle, user_id: @user.id)
        @maintenance = create(:maintenance, vehicle_id: @vehicle.id)
      end

      it 'returns all the maintenance exipring this month' do
        create(:maintenance_next_month, vehicle_id: @vehicle.id)
        expect(@vehicle.expiring_maintenances).to eq([@maintenance])
      end
    end
  end

  describe 'sanctions' do
    before :each do
      @user = create(:user)
      @vehicle = create(:vehicle, user_id: @user.id)
      @vendor = create(:vendor, user_id: @user.id)

      sanction1 = create(:sanction, user_id: @user.id)
      sanction2 = create(:sanction, user_id: @user.id)

      @vehicle.sanctions << sanction1
      @vehicle.sanctions << sanction2
    end

    it 'total all fuel receipts' do
      expect(@vehicle.sanctions_total).to eq(3200.44)
    end

    it 'returns all sanctions between dates' do
      sanction_next_month = create(
        :sanction,
        user_id: @user.id,
        date: Date.today.next_month
      )
      @vehicle.sanctions << sanction_next_month
      expect(
        @vehicle.sanctions.all_between_dates(
          Date.today.next_month.beginning_of_month,
          Date.today.next_month.end_of_month)
      ).to eq([sanction_next_month])
    end
  end

  describe 'fuel receipts' do
    let(:user) { create(:user) }

    before :each do
      @user = user
      @vehicle = create(:vehicle, user_id: @user.id)
      @vendor = create(:vendor, user_id: @user.id)
      create(:fuel_receipt, vehicle_id: @vehicle.id, vendor_id: @vendor.id)
      create(:fuel_receipt, vehicle_id: @vehicle.id, vendor_id: @vendor.id)
    end

    it 'total all fuel receipts' do
      expect(@vehicle.fuel_receipts_total).to eq(460.0)
    end

    it 'total fuel receipts between period' do
      fuel_receipt_next_month = create(
        :fuel_receipt,
        vehicle_id: @vehicle.id,
        vendor_id: @vendor.id,
        date_of_issue: Date.today.next_month
      )
      expect(
        @vehicle.fuel_receipts_total(
          Date.today.next_month.beginning_of_month,
          Date.today.next_month.end_of_month)
      ).to eq(fuel_receipt_next_month.total.to_f)
    end
  end
end
