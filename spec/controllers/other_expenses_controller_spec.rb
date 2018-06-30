require 'rails_helper'

RSpec.describe Api::V1::OtherExpensesController, type: :controller do
  describe 'index' do
    it 'returns and empty array if no other expenses' do
      get '/api/v1/other_expenses'
      other_expenses = JSON.parse(response.body)
      expect(other_expenses).to eq([]);
    end
  end
end
