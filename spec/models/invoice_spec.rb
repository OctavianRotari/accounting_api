require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to(:company) }
  it { should belong_to(:vehicle) }

  it { should have_many(:vehicle_fields) }
  it { should have_many(:taxable_vat_fields) }
  it { should have_many(:payments) }
end
