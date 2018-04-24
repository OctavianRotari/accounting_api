require 'rails_helper'

RSpec.describe Employee, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:salaries) }

  describe 'user adds a new employee' do
    it 'fails if there is no desc or total or date' do
      employee = build(:employee, name: nil, contract_start_date: nil, role: nil)
      employee.save
      expect(employee.errors.full_messages).to eq(["Name required", "Contract start date required", "Role required"])
    end
  end
end
