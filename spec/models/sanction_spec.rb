require 'rails_helper'

RSpec.describe Sanction, type: :model do
  it { should belong_to(:user) }
  it { should have_and_belong_to_many(:payments) }
  it { should have_and_belong_to_many(:vehicles) }
end
