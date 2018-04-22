require 'rails_helper'

RSpec.describe FuelReceipt, type: :model do
  it { should belong_to(:vendor) }
  it { should belong_to(:vehicle) }

  it { should have_and_belong_to_many(:invoices) }
end
