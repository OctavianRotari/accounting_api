require 'rails_helper'

RSpec.describe Receipt, type: :model do
  it { should belong_to(:insurance) }
end
