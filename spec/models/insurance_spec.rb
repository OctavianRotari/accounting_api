require 'rails_helper'

RSpec.describe Insurance, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:insurance_receipts) }
  it { should have_and_belong_to_many(:companies) }
  it { should have_and_belong_to_many(:vehicles) }
end
