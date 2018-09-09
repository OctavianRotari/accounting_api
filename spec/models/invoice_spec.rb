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
        [
          "Date required",
          "Deadline required",
          "Description required",
          "Serial number required"
        ]
      )
    end

    describe 'line items' do
      before :each do
        @invoice = create(:invoice, :items)
      end

      it 'creates more line item' do
        expect(@invoice.line_items.length).to eq(2)
      end
    end
  end

  describe 'total' do
    before :each do
      @invoice = create(:invoice, :items)
    end

    it 'returns the total of all the line items' do
      expect(@invoice.total.to_f).to eq(19.98)
    end
  end

  describe 'get invoices between dates' do
    before :each do
      create(:invoice, :items)
      user = User.first
      vendor = create(:vendor, user_id: user.id)
      @invoice = create(:invoice, :items, date: Date.today.next_month, vendor_id: vendor.id)
    end

    it 'returns invoices between dates' do
      expect(
        Invoice.all_between_dates(
          Date.today.next_month.beginning_of_month,
          Date.today.next_month.end_of_month
        )
      ).to eq([@invoice])
    end

    it 'returns total between dates' do
      create(:line_item, invoice_id: @invoice.id)
      create(:line_item, invoice_id: @invoice.id)
      expect(
        Invoice.total_between_dates(
          Date.today.next_month.beginning_of_month,
          Date.today.next_month.end_of_month
        )
      ).to eq(39.96)
    end
  end
end
