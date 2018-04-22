require 'rails_helper'

RSpec.describe Maintenance, type: :model do
  it { should belong_to(:vehicle) }
end
