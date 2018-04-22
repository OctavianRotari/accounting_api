require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { should have_and_belong_to_many(:invoices) }
  it { should have_and_belong_to_many(:sanctions) }
  it { should have_and_belong_to_many(:salaries) }
end
