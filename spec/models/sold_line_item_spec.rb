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
end
