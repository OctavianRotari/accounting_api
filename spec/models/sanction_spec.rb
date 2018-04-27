require 'rails_helper'

RSpec.describe Sanction, type: :model do
  it { should belong_to(:user) }
  it { should have_and_belong_to_many(:payments) }
  it { should have_and_belong_to_many(:vehicles) }

  describe 'is created' do
    it 'fails if there is no desc or total or date' do
      sanction = build(:sanction, total: nil, date: nil, deadline: nil)
      sanction.save
      expect(sanction.errors.full_messages).to eq(["Total required", "Date required", "Deadline required"])
    end

    describe 'vehicle saction' do
      it 'if vehicle id supplied' do
        sanction = create(:sanction)
        user = User.first
        vehicle = create(:vehicle, user_id: user.id)
        sanction.create_fine_association(vehicle.id)
        expect(sanction.vehicles).to eq([vehicle])
      end
    end

    describe 'success' do
      let(:sanction) { create(:sanction) }

      before :each do
        sanction
        @payment = sanction.create_payment({
          paid: 200,
          method_of_payment: 'banca',
          payment_date: Date.current.beginning_of_month + 3
        })
      end

      it 'it pays part of sanction and creates payment' do
        expect(sanction.payments).to eq([@payment])
      end

      it 'return an error if the payment is bigger that the sanction' do
        expect{
          sanction.create_payment({
            paid: 1500,
            method_of_payment: 'banca',
            payment_date: Date.current.beginning_of_month + 3
          })
        }.to raise_error('The payment total is bigger than the sanction total')
      end

      it 'returns false if sanction has not been paid yet' do
        sanction.create_payment({
          paid: 200,
          method_of_payment: 'banca',
          payment_date: Date.current.beginning_of_month + 3
        })
        expect(sanction.paid?).to eq(false)
      end

      it 'returns true if sanction has not been paid yet' do
        sanction.create_payment({
          paid: 1400.22,
          method_of_payment: 'banca',
          payment_date: Date.current.beginning_of_month + 3
        })
        expect(sanction.paid?).to eq(true)
      end

      it 'calculates total sactions' do
        user = User.first
        create(:sanction, user_id: user.id)
        expect(user.sanctions.total).to eq(3200.44)
      end
    end
  end
end
