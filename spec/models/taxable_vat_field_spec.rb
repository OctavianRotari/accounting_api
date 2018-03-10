require 'rails_helper'

RSpec.describe TaxableVatField, type: :model do
  it { should belong_to(:invoice) }
end
