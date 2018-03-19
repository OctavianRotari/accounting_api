require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:line_items) }
  it { should have_and_belong_to_many(:companies) }
  it { should have_and_belong_to_many(:payments) }
  it { should have_and_belong_to_many(:vehicles) }
end
