require 'rails_helper'

RSpec.describe Employee, type: :model do
  it { should have_many(:salaries) }
end
