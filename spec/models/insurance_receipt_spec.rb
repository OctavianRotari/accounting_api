require 'rails_helper'

RSpec.describe InsuranceReceipt, type: :model do
  it { should belong_to(:insurance) }
  it { should have_and_belong_to_many(:payments) }
end
