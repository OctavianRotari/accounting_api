require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:categories) }
  it { should have_many(:active_invoices) }
  it { should have_many(:insurances) }
  it { should have_many(:invoices) }
  it { should have_many(:tickets) }
  it { should have_many(:vehicles) }
  it { should have_many(:companies) }
  it { should have_many(:fuel_receipts) }
  it { should have_many(:insurance_receipts) }
  it { should have_many(:line_items) }
  it { should have_many(:payments) }
  it { should have_many(:sold_line_items) }
end
