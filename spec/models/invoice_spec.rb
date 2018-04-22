require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to(:vendor) }
  it { should have_and_belong_to_many(:payments) }
  it { should have_and_belong_to_many(:fuel_receipts) }
  it { should have_and_belong_to_many(:vehicles) }
end
