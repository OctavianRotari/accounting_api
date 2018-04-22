require 'rails_helper'

RSpec.describe Insurance, type: :model do
  it { should belong_to(:vendor) }
  it { should have_and_belong_to_many(:vehicles) }
  it { should have_many(:insurance_receipts) }
end
