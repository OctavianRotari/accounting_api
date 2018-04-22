require 'rails_helper'

RSpec.describe VehicleTax, type: :model do
  it { should belong_to(:vehicle) }
  it { should have_and_belong_to_many(:payments) }
end
