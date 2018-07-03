require 'rails_helper'

RSpec.describe VehicleType, type: :model do
  it { should have_many(:vehicles) }
  it { should belong_to(:user) }
end
