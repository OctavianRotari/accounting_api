require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it { should belong_to(:invoice) }
  it { should have_and_belong_to_many(:fuel_receipts) }
end
