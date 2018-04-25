require 'rails_helper'

RSpec.describe Salary, type: :model do
  it { should belong_to(:employee) }
  it { should have_and_belong_to_many(:payments) }

  describe 'a salary is paid' do
    it 'fails if there is no desc or total or date' do
      salary = build(:salary, total: nil, month: nil, deadline: nil)
      salary.save
      expect(salary.errors.full_messages).to eq(["Total required", "Month required", "Deadline required"])
    end

    describe 'success' do
      let(:salary) { create(:salary) }

      before :each do
        salary
      end

      it 'it pays part of salary and creates payment' do
        payment = salary.create_payment({
          paid: 200,
          method_of_payment: 'banca',
          payment_date: Date.current.beginning_of_month + 3
        })
        expect(salary.payments).to eq([payment])
      end

      it 'return an error if the payment is bigger that the salary' do
        expect{
          salary.create_payment({
            paid: salary.total + 1,
            method_of_payment: 'banca',
            payment_date: Date.current.beginning_of_month + 3
          })
        }.to raise_error('The payment total is bigger than the salary total')
      end
    end
  end
end

