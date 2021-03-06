require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:vendors) }
  it { should have_many(:contribution_types) }
  it { should have_many(:other_expenses) }
  it { should have_many(:financial_contributions) }
  it { should have_many(:employees) }
  it { should have_many(:sanctions) }
  it { should have_many(:vehicles) }
  it { should have_many(:vehicle_types) }
end
