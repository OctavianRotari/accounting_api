require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it { should belong_to(:user) }

  it { should have_many(:fuel_receipts) }
  it { should have_many(:insurances) }
  it { should have_many(:tickets) }
end
