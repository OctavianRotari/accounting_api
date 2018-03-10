require 'rails_helper'

describe Category, type: :unit do
  it { should belong_to(:user) }
end
