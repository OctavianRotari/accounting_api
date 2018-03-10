require 'rails_helper'

RSpec.describe Insurance, type: :model do
  it { should belong_to(:company) }
  it { should belong_to(:vehicle) }
end
