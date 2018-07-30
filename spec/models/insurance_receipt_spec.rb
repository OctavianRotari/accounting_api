require 'rails_helper'

RSpec.describe InsuranceReceipt, type: :model do
  it { should belong_to(:insurance) }
  it { should belong_to(:payments) }
end
