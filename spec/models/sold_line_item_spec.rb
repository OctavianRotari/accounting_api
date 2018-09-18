require 'rails_helper'

RSpec.describe SoldLineItem, type: :model do
  it { should belong_to(:active_invoice) }
  it { should have_one(:sold_line_item_to_load) }

  describe 'loads' do
    it 'creates success' do
      active_invoice = create(:active_invoice, :loads)
      load = Load.first
      expect(SoldLineItem.create_load_line_item(load, active_invoice.id)).to eq(true)
    end

    it 'udpates success' do
      create(:active_invoice, :loads)
      sold_line_item_params = {
        'total': 400.0,
      }
      sold_line_item = SoldLineItem.first
      expect(sold_line_item.update(sold_line_item_params)).to eq(true)
      load = sold_line_item.load
      expect(load[:total]).to eq(400.0)
    end
  end

  describe 'delete line item' do
    before :all do
      sold_line_item = attributes_for(:sold_line_item)
      @active_invoice = create(:active_invoice)
      sold_line_item[:active_invoice_id] = @active_invoice.id 
      @sold_line_items = SoldLineItem.create([sold_line_item])
    end

    it 'error last sold_line_item' do
      sold_line_item = @sold_line_items.first.destroy
      expect(sold_line_item.errors.full_messages).to eq(["Last sold_line_item for active_invoice cannot be deleted"])
    end

    it 'success' do
      sold_line_item = attributes_for(:sold_line_item)
      sold_line_item[:active_invoice_id] = @active_invoice.id 
      sold_line_item = SoldLineItem.create(sold_line_item)
      expect { sold_line_item.destroy }.to change { SoldLineItem.count }.by(-1)
      expect(sold_line_item.sold_line_item_to_load).to eq(nil)
    end
  end
end
