require 'rails_helper'

RSpec.describe InsuranceReceipt, type: :model do
  it { should belong_to(:insurance) }
  it { should have_and_belong_to_many(:payments) }

  describe 'create insurance_receipts' do
    before :each do
      @insurance = create(:insurance, :with_vendor, :valid)
    end

    it 'creates a new insurance receipt connected to a payment' do
      create(:insurance_receipt, :valid, insurance_id: @insurance.id)
      expect(InsuranceReceipt.all.length).to eq(1)
      expect(Payment.all.length).to eq(1)
      expect(InsuranceReceipt.first.payments).to eq(Payment.all)
    end

    it 'returns error if receipt is not valid' do
      insurance_receipt = attributes_for(:insurance_receipt, :invalid, insurance_id: @insurance.id)
      receipt = InsuranceReceipt.create(insurance_receipt)
      expect(receipt.errors.full_messages).to eq([
        "Date required", "Total required", "Method of payment required"
      ])
    end

    it 'returns error if total receipts + new receipt is bigger than total insurance' do
      insurance_receipt = attributes_for(:insurance_receipt, :valid, total: 2000, insurance_id: @insurance.id)
      InsuranceReceipt.create(insurance_receipt)
      receipt = InsuranceReceipt.create(insurance_receipt)
      expect(receipt.errors.full_messages).to eq(["Total Total too big"])
    end
  end
end
