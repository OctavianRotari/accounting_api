require 'rails_helper'

RSpec.describe ActiveInvoice, type: :model do
  it { should belong_to(:vendor) }
  it { should have_many(:sold_line_items) }
  it { should have_and_belong_to_many(:revenues) }

  describe 'create' do
    it 'fails if there if the fields are not present' do
      active_invoice = build(
        :active_invoice,
        date: nil,
        deadline: nil,
        description: nil,
        serial_number: nil
      )
      active_invoice.save
      expect(active_invoice.errors.full_messages).to eq(
        [ "Date required", "Deadline required", "Description required", "Serial number required" ]
      )
    end

    describe 'sold line items' do
      before :each do
        @active_invoice = create(:active_invoice)
      end

      it 'creates one line item' do
        sold_line_item_1 = attributes_for(:sold_line_item, active_invoice_id: @active_invoice.id)
        @active_invoice.create_sold_line_items([sold_line_item_1])
        expect(@active_invoice.sold_line_items.length).to eq(1)
      end

      it 'creates one line item' do
        sold_line_item_1 = attributes_for(:sold_line_item, active_invoice_id: @active_invoice.id)
        sold_line_item_2 = attributes_for(:sold_line_item, active_invoice_id: @active_invoice.id)
        @active_invoice.create_sold_line_items([sold_line_item_1, sold_line_item_2])
        expect(@active_invoice.sold_line_items.length).to eq(2)
      end
    end
  end

  describe 'total' do
    before :each do 
      @active_invoice = create(:active_invoice)
    end

    it 'returns the total of all the sold line items' do
      sold_line_item_1 = attributes_for(:sold_line_item, active_invoice_id: @active_invoice.id)
      sold_line_item_2 = attributes_for(:sold_line_item, active_invoice_id: @active_invoice.id)
      @active_invoice.create_sold_line_items([sold_line_item_1, sold_line_item_2])
      expect(@active_invoice.total).to eq(2000.0)
    end
  end

  describe 'get active invoices between dates' do
    before :each do
      create(:active_invoice)
      user = User.first
      vendor = create(:vendor, user_id: user.id)
      @active_invoice = create(:active_invoice, date: Date.today.next_month, vendor_id: vendor.id)
    end

    it 'returns active invoices between dates' do
      expect(
        ActiveInvoice.all_between_dates(
          Date.today.next_month.beginning_of_month,
          Date.today.next_month.end_of_month
        )
      ).to eq([@active_invoice])
    end

    it 'returns total between dates' do
      create(:sold_line_item, active_invoice_id: @active_invoice.id)
      create(:sold_line_item, active_invoice_id: @active_invoice.id)
      expect(
        ActiveInvoice.total_between_dates(
          Date.today.next_month.beginning_of_month,
          Date.today.next_month.end_of_month
        )
      ).to eq(2000)
    end
  end
end
