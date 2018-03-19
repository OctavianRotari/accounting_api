require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it { should belong_to(:user) }

  it { should have_many(:fuel_receipts) }
  it { should have_and_belong_to_many(:invoices) }
  it { should have_and_belong_to_many(:tickets) }
  it { should have_and_belong_to_many(:insurances) }
end
