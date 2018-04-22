require 'rails_helper'

RSpec.describe Salary, type: :model do
  it { should belong_to(:employee) }
  it { should have_and_belong_to_many(:payments) }
end

