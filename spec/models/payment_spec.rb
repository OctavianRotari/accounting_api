require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { should have_and_belong_to_many(:invoice) }
  it { should have_and_belong_to_many(:active_invoice) }
end
