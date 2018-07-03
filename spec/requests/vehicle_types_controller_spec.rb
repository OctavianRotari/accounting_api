require 'rails_helper'

RSpec.describe 'Vehicle types Api', type: :request do
  describe 'GET /v1/vehicle_types' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }

    before do
      create(:vehicle_type, user_id: user.id)
      get '/v1/vehicle_types', headers: auth_headers
    end

    it 'return vehicle_types for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the address of the vendor is correct' do
      vehicle_types = json[0]
      expect(vehicle_types['desc']).to eq('MyString')
    end
  end
end
