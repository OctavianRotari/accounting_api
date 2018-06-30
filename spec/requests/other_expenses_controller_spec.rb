require 'rails_helper'

RSpec.describe 'Other expenses Api', type: :request do
  describe 'GET /v1/other_expenses' do
    let(:auth_headers) { create(:user).create_new_auth_token }

    before do
      get '/v1/other_expenses', headers: auth_headers
    end

    it 'returns other expeses' do
      expect(json).to eq([]);
    end
  end
end
