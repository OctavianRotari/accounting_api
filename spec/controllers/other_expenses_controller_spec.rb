require 'rails_helper'

class OtherExpensesController < ActionDispatch::IntegrationTest
  describe 'index' do
    it 'returns and empty array if no other expenses' do
      byebug
      expect(get :other_expenses).to eq([]);
    end
  end
end
