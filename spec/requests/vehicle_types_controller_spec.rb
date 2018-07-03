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

  describe 'POST /v1/vehicle_types' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:valid_params) do
      {
        vehicle_type: {
          desc: 'autocarro'
        }
      }
    end
    let(:invalid_params) do
      {
        vehicle_type: {}
      }
    end

    it 'create a vehicle type' do
      expect {
        post "/v1/vehicle_types",
        headers: auth_headers,
        params: valid_params
      }.to change(VehicleType, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'create a vehicle type error' do
      post "/v1/vehicle_types",
      headers: auth_headers,
      params: invalid_params
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: vehicle_type')
    end
  end
end
