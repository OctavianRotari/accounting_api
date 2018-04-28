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
        payment = attributes_for(:payment, total: 200)
        salary.payments.create(payment)
      end

      it 'returns false if salary has not been paid yet' do
        payment2 = attributes_for(:payment, total: 200)
        salary.payments.create(payment2)
        expect(salary.paid?).to eq(false)
      end

      it 'returns true if salary has been paid yet' do
        payment2 = attributes_for(:payment, total: 1400.22)
        salary.payments.create(payment2)
        expect(salary.paid?).to eq(true)
      end

      it 'calculates total sactions' do
        employee = Employee.first
        create(:salary, employee_id: employee.id)
        expect(employee.salaries.total).to eq(3200.44)
      end

      it 'calculates total paid sactions' do
        employee = Employee.first
        salary = create(:salary, employee_id: employee.id)
        payment2 = attributes_for(:payment, total: 1400.22)
        salary.payments.create(payment2)
        expect(salary.total_paid).to eq(1400.22)
      end
    end
  end
end
