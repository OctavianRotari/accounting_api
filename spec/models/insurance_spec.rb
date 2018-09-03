require 'rails_helper'

RSpec.describe Insurance, type: :model do
  it { should belong_to(:vendor) }
  it { should have_and_belong_to_many(:vehicles) }
  it { should have_many(:insurance_receipts) }

  describe 'create' do
    it 'fails if there is no filled fields' do
      insurance = build(:insurance, :invalid)
      insurance.save
      expect(insurance.errors.full_messages).to eq([
        "Vendor must exist", 
        "Date required", 
        "Deadline required", 
        "Description required", 
        "Total required", 
        "Serial of contract required", 
        "Payment recurrence required"
      ])
    end

    describe 'line items' do
      before :each do
        @insurance = create(:insurance, :with_vendor, :valid)
      end

      it 'creates a new insurance receipt connected to a payment' do
        insurance_receipt = attributes_for(:insurance_receipt, :valid)
        @insurance.add_receipt(insurance_receipt)
        expect(@insurance.insurance_receipts.length).to eq(1)
        expect(Payment.all.length).to eq(1)
      end

      it 'returns error if receipt is not valid' do
        insurance_receipt = attributes_for(:insurance_receipt, :invalid)
        receipt = @insurance.add_receipt(insurance_receipt)
        expect(receipt.errors.full_messages).to eq([
          "Date required", "Total required", "Method of payment required"
        ])
      end
    end
  end
end
