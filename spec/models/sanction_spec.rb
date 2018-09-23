require 'rails_helper'

RSpec.describe Sanction, type: :model do
  it { should belong_to(:user) }
  it { should have_and_belong_to_many(:payments) }
  it { should have_and_belong_to_many(:vehicles) }

  describe 'is created' do
    it 'fails if there is no desc or total or date' do
      sanction = build(:sanction, total: nil, date: nil, deadline: nil)
      sanction.save
      expect(sanction.errors.full_messages).to eq(
        [
          "User must exist", 
          "Total required", 
          "Date required", 
          "Deadline required"
        ]
      )
    end

    describe 'vehicle saction' do
      it 'if vehicle id supplied' do
        sanction = create(:sanction)
        user = User.first
        vehicle_type = create(:vehicle_type, user_id: user.id)
        vehicle = create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: user.id)
        sanction.associate_to(vehicle.id)
        expect(sanction.vehicles).to eq([vehicle])
      end
    end

    describe 'success' do
      let(:sanction) { create(:sanction) }

      before :each do
        sanction
        payment = attributes_for(:payment, total: 200)
        sanction.payments.create(payment)
      end

      it 'calculates total sactions' do
        user = User.first
        create(:sanction, user_id: user.id)
        expect(user.sanctions.total).to eq(3200.44)
      end
    end
  end

  describe 'get sanctions between dates' do
    before :each do
      create(:sanction)
      @user = User.first
      @sanction = create(:sanction, date: Date.today.next_month, user_id: @user.id)
    end

    it 'return an error if the no params to function' do
      expect{
        Sanction.all_between_dates()
      }.to raise_error('Supply start_date & end_date params')
    end

    it 'returns sanctions registered between dates' do
      expect(
        Sanction.all_between_dates(
          Date.today.next_month.beginning_of_month,
          Date.today.next_month.end_of_month
        )
      ).to eq([@sanction])
    end

    it 'return an error if the no params to function' do
      expect{
        Sanction.total_between_dates()
      }.to raise_error('Supply start_date & end_date params')
    end

    it 'returns total between dates' do
      expect(
        Sanction.total_between_dates(
          Date.today.next_month.beginning_of_month,
          Date.today.next_month.end_of_month
        )
      ).to eq(1600.22)
    end
  end
end
