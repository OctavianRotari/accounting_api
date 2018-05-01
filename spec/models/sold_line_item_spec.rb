require 'rails_helper'

RSpec.describe SoldLineItem, type: :model do
  it { should belong_to(:active_invoice) }
  it { should have_and_belong_to_many(:loads) }
end
