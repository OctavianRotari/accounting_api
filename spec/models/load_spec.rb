require 'rails_helper'

RSpec.describe Load, type: :model do
  it { should belong_to(:vendor) }
  it { should belong_to(:vehicle) }

  it { should have_and_belong_to_many(:active_invoices) }
end
