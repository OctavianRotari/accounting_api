require 'rails_helper'

RSpec.describe ActiveInvoice, type: :model do
  it { should belong_to(:vendor) }
  it { should have_many(:sold_line_items) }
  it { should have_and_belong_to_many(:revenues) }
end
