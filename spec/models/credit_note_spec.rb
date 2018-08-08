require 'rails_helper'

RSpec.describe CreditNote, type: :model do
  it { should belong_to(:vendor) }
  it { should have_and_belong_to_many(:revenues) }

  describe 'create' do
    it 'fails if there if the fields are not present' do
      credit_note = build(
        :credit_note,
        date: nil,
        total: nil,
      )
      credit_note.save
      expect(credit_note.errors.full_messages).to eq(
        ["Date required", "Total required"]
      )
    end
  end

  describe 'total' do
    before :each do 
      vendor = create(:vendor)
      @credit_note = create(:credit_note, vendor_id: vendor.id)
    end

    it 'returns the total of all the line items' do
      expect(CreditNote.total).to eq(100.0)
    end
  end

  describe 'get active invoices between dates' do
    before :each do
      create(:credit_note)
      user = User.first
      vendor = create(:vendor, user_id: user.id)
      @credit_note = create(:credit_note, date: Date.today.next_month, vendor_id: vendor.id)
    end

    it 'returns active invoices between dates' do
      expect(
        CreditNote.all_between_dates(
          Date.today.next_month.beginning_of_month,
          Date.today.next_month.end_of_month
        )
      ).to eq([@credit_note])
    end

    it 'returns total between dates' do
      expect(
        CreditNote.total_between_dates(
          Date.today.next_month.beginning_of_month,
          Date.today.next_month.end_of_month
        )
      ).to eq(100)
    end
  end
end
