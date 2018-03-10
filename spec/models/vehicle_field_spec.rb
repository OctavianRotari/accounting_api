require 'rails_helper'

RSpec.describe VehicleField, type: :model do
  it { should belong_to(:invoice) }
  it { should belong_to(:vehicle) }
end
