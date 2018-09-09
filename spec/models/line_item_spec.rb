require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it { should belong_to(:invoice) }
  it { should have_one(:line_item_to_fuel_receipt) }

  describe 'line item to fuel_receipt' do
    before :all do
      create(:invoice, :fuel_receipts)
    end

    it 'return fuel receipt' do
      line_item = LineItem.first
      expect(line_item.fuel_receipt).to eq(FuelReceipt.first)
    end

    it 'deletes line item and line_item_to_fuel_receipt' do
      line_item = LineItem.first
      expect(line_item.destroy).to eq(line_item)
    end
  end

  describe 'delete line item' do
    before :all do
      line_item = attributes_for(:line_item)
      @invoice = create(:invoice, items: [line_item], vendor_id: Vendor.first.id)
      line_item[:invoice_id] = @invoice.id 
      @line_items = LineItem.create([line_item])
    end

    it 'error last line_item' do
      line_item = @line_items.first.destroy
      expect(line_item.errors.full_messages).to eq(["Last line_item for invoice cannot be deleted"])
    end

    it 'success' do
      line_item = attributes_for(:line_item)
      line_item[:invoice_id] = @invoice.id 
      line_item = LineItem.create(line_item)
      expect { line_item.destroy }.to change { LineItem.count }.by(-1)
      expect(line_item.line_item_to_fuel_receipt).to eq(nil)
    end
  end
end
