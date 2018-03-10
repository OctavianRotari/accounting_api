require 'rails_helper'

RSpec.describe FuelReceipt, type: :model do
  it { should belong_to(:company) }
  it { should belong_to(:vehicle) }
end
