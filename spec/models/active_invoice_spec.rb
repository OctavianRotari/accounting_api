require 'rails_helper'

RSpec.describe ActiveInvoice, type: :model do
  it { should belong_to(:vendor) }
  it { should have_many(:sold_line_items) }
  it { should have_and_belong_to_many(:revenues) }

  describe 'create' do
    it 'fails if there if the fields are not present' do
      active_invoice = build(
        :active_invoice,
        date_of_issue: nil,
        deadline: nil,
        description: nil,
        serial_number: nil
      )
      active_invoice.save
      expect(active_invoice.errors.full_messages).to eq(
        [ "Date of issue required", "Deadline required", "Description required", "Serial number required"]
      )
    end

    describe 'sold line items' do
      before :each do
        @active_invoice = create(:active_invoice)
      end

      it 'creates one line item' do
        sold_line_item_1 = attributes_for(:line_item, active_invoice_id: @active_invoice.id)
        @active_invoice.create_sold_line_items([sold_line_item_1])
        expect(@active_invoice.sold_line_items.length).to eq(1)
      end

      it 'creates one line item' do
        sold_line_item_1 = attributes_for(:line_item, active_invoice_id: @active_invoice.id)
        sold_line_item_2 = attributes_for(:line_item, active_invoice_id: @active_invoice.id)
        @active_invoice.create_sold_line_items([sold_line_item_1, sold_line_item_2])
        expect(@active_invoice.sold_line_items.length).to eq(2)
      end
    end
  end

  describe 'total' do
    before :each do 
      @active_invoice = create(:active_invoice)
    end

    it 'returns the total of all the line items' do
      sold_line_item_1 = attributes_for(:line_item, active_invoice_id: @active_invoice.id)
      sold_line_item_2 = attributes_for(:line_item, active_invoice_id: @active_invoice.id)
      @active_invoice.create_sold_line_items([sold_line_item_1, sold_line_item_2])
      expect(@active_invoice.total).to eq(19.98)
    end
  end
end
