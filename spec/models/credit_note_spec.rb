require 'rails_helper'

RSpec.describe CreditNote, type: :model do
  it { should belong_to(:vendor) }
  it { should have_and_belong_to_many(:revenues) }
end
