require 'rails_helper'

RSpec.describe Salary, type: :model do
  it { should belong_to(:employee) }
  it { should have_and_belong_to_many(:payments) }

  describe 'a salary is created' do
    it 'fails if there is no desc or total or date' do
      salary = build(:salary, total: nil, month: nil, deadline: nil)
      salary.save
      expect(salary.errors.full_messages).to eq(["Total required", "Month required", "Deadline required"])
    end

    describe 'success' do
      let(:salary) { create(:salary) }

      before :each do
        salary
        @payment = salary.create_payment({
          paid: 200,
          method_of_payment: 'banca',
          payment_date: Date.current.beginning_of_month + 3
        })
      end

      it 'it pays part of salary and creates payment' do
        expect(salary.payments).to eq([@payment])
      end

      it 'return an error if the payment is bigger that the salary' do
        expect{
          salary.create_payment({
            paid: 1500,
            method_of_payment: 'banca',
            payment_date: Date.current.beginning_of_month + 3
          })
        }.to raise_error('The payment total is bigger than the salary total')
      end

      it 'returns false if salary has not been paid yet' do
        salary.create_payment({
          paid: 200,
          method_of_payment: 'banca',
          payment_date: Date.current.beginning_of_month + 3
        })
        expect(salary.paid?).to eq(false)
      end

      it 'returns true if salary has not been paid yet' do
        salary.create_payment({
          paid: 1400.22,
          method_of_payment: 'banca',
          payment_date: Date.current.beginning_of_month + 3
        })
        expect(salary.paid?).to eq(true)
      end

      it 'calculates total sactions' do
        employee = Employee.first
        create(:salary, employee_id: employee.id)
        expect(employee.salaries.total).to eq(3200.44)
      end
    end
  end
end
