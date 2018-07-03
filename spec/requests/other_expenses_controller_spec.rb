require 'rails_helper'

RSpec.describe 'Other expenses Api', type: :request do
  describe 'GET /v1/other_expenses' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }

    before do
      create(:other_expense, user_id: user.id)
      get '/v1/other_expenses', headers: auth_headers
    end

    it 'return other one other expense for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the total of the first other expense is correct' do
      other_expense = json[0]
      expect(other_expense['total']).to eq('10.3')
    end
  end
end
