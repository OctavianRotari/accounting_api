require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to(:vendor) }
  it { should have_many(:line_items) }
  it { should have_and_belong_to_many(:payments) }
  it { should have_and_belong_to_many(:vehicles) }

  describe 'create' do
    it 'fails if there is no desc all fields ' do
      invoice = build(
        :invoice,
        date: nil,
        deadline: nil,
        description: nil,
        serial_number: nil
      )
      invoice.save
      expect(invoice.errors.full_messages).to eq(
        [ "Date required", "Deadline required", "Description required", "Serial number required"]
      )
    end

    describe 'line items' do
      before :each do
        @invoice = create(:invoice)
      end

      it 'creates one line item' do
        line_item_1 = attributes_for(:line_item, invoice_id: @invoice.id)
        @invoice.create_line_items([line_item_1])
        expect(@invoice.line_items.length).to eq(1)
      end

      it 'creates more line item' do
        line_item_1 = attributes_for(:line_item, invoice_id: @invoice.id)
        line_item_2 = attributes_for(:line_item, invoice_id: @invoice.id)
        @invoice.create_line_items([line_item_1, line_item_2])
        expect(@invoice.line_items.length).to eq(2)
      end

      it 'connects line items to fuel receipts' do
        user = User.first
        vendor = create(:vendor, user_id: user.id)
        vehicle_type = create(:vehicle_type, user_id: user.id)
        vehicle = create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: user.id)
        fuel_receipts_ids = [
          create(:fuel_receipt, vendor_id: vendor.id, vehicle_id: vehicle.id).id,
          create(:fuel_receipt, vendor_id: vendor.id, vehicle_id: vehicle.id).id
        ]
        @invoice.create_line_items(fuel_receipts_ids, :fuel_receipt)
        expect(@invoice.line_items.length).to eq(2)
      end
    end
  end

  describe 'total' do
    before :each do 
      @invoice = create(:invoice)
    end

    it 'returns the total of all the line items' do
      line_item_1 = attributes_for(:line_item, invoice_id: @invoice.id)
      line_item_2 = attributes_for(:line_item, invoice_id: @invoice.id)
      @invoice.create_line_items([line_item_1, line_item_2])
      expect(@invoice.total).to eq(19.98)
    end
  end
end
