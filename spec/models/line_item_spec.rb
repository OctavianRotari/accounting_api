require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it { should belong_to(:invoice) }
  it { should have_one(:line_item_to_fuel_receipt) }

  describe 'line item to fuel_receipt' do
    before :each do
      create(:invoice, :fuel_receipts)
    end

    it 'return fuel receipt' do
      line_item = LineItem.first
      expect(line_item.fuel_receipt).to eq(FuelReceipt.first)
    end
  end

  describe 'delete line item' do
    before :each do
      line_item = attributes_for(:line_item)
      @invoice = create(:invoice, items: [line_item])
      line_item[:invoice_id] = @invoice.id 
      @line_items = LineItem.create([line_item])
    end

    it 'returns error if it is the last item for invoice' do
      line_item = @line_items.first.destroy
      expect(line_item.errors.full_messages).to eq(["Last line_item for invoice cannot be deleted"])
    end

    it 'successfully deletes line_item' do
      line_item = attributes_for(:line_item)
      line_item[:invoice_id] = @invoice.id 
      line_item = LineItem.create(line_item)
      line_item.destroy
      expect(line_item.errors.full_messages).to eq([])
    end
  end
end
