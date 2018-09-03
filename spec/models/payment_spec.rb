require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { should have_and_belong_to_many(:invoices) }
  it { should have_and_belong_to_many(:sanctions) }
  it { should have_and_belong_to_many(:salaries) }

  describe 'create' do
    it 'fails if there is no filled fields' do
      payment = build(:payment, :invalid)
      payment.save
      expect(payment.errors.full_messages).to eq([
        "Date required", "Total required", "Method of payment required"
      ])
    end
  end
end
