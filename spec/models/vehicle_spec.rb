require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:fuel_receipts) }
  it { should have_many(:vehicle_taxes) }
  it { should have_many(:maintenances) }
  it { should have_many(:loads) }

  it { should have_and_belong_to_many(:invoices) }
  it { should have_and_belong_to_many(:insurances) }
end
