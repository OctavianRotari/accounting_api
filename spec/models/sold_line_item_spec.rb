require 'rails_helper'

RSpec.describe SoldLineItem, type: :model do
  it { should belong_to(:active_invoice) }
end
