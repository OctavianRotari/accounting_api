require 'rails_helper'

RSpec.describe 'Vehicle Api', type: :request do
  describe 'GET /v1/vehicles' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }

    before do
      create(:vehicle, user_id: user.id)
      get '/v1/vehicles', headers: auth_headers
    end

    it 'return vehicles for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the address of the vendor is correct' do
      vehicle = json[0]
      expect(vehicle['plate']).to eq('EH535RV')
    end
  end
end
