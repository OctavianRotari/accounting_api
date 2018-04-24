require 'rails_helper'

RSpec.describe ContributionType, type: :model do
  it { should have_many(:financial_contributions) }
end
