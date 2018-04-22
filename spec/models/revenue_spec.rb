require 'rails_helper'

RSpec.describe Revenue, type: :model do
  it { should have_and_belong_to_many(:active_invoices) }
  it { should have_and_belong_to_many(:credit_notes) }
end
