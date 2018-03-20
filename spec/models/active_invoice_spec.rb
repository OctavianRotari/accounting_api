require 'rails_helper'

RSpec.describe ActiveInvoice, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:sold_line_items) }
  it { should have_and_belong_to_many(:payments) }

  describe 'user create a active invoice' do
    let(:user) { create(:user) }
    let(:category) { create(:category, user_id: user.id) }
    let(:company) { create(:company, category_id: category.id) }

    before :each do
      user
      category
      company
    end

    it 'fails if there is no user id' do
      active_invoice = build(:active_invoice)
      active_invoice.save
      expect(active_invoice.errors.full_messages).to eq(["User must exist"])
    end

    it 'fails if there is no company_id' do
      active_invoice = build(:active_invoice, user_id: user.id)
      active_invoice.save
      expect(active_invoice.errors.full_messages).to eq([])
    end
  end
end
