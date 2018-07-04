require 'rails_helper'

RSpec.describe 'Vehicle Api', type: :request do
  describe 'GET /v1/vehicles' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }

    before do
      vehicle_type = create(:vehicle_type, user_id: user.id)
      create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: user.id)
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

  describe 'POST /v1/vehicles' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }
    let(:valid_params) do
      {
        vehicle: {
          vehicle_type_id: vehicle_type.id,
          plate: 'EH2543BX',
          roadworthiness_check_date: Date.today.at_beginning_of_month.next_month,
        }
      }
    end
    let(:invalid_params) do
      {
        vehicle: {}
      }
    end

    it 'create a vehicle' do
      expect {
        post "/v1/vehicles",
        headers: auth_headers,
        params: valid_params
      }.to change(Vehicle, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'create a vehicle error' do
      post "/v1/vehicles",
        headers: auth_headers,
        params: invalid_params
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: vehicle')
    end
  end

  describe 'PUT /v1/vehicles/:id' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }
    let(:valid_params) do
      {
        vehicle: {
          vehicle_type_id: vehicle_type.id,
          plate: 'EH2543BX',
          roadworthiness_check_date: Date.today.at_beginning_of_month.next_month,
        }
      }
    end

    before do
      @vehicle = create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: user.id)
    end

    it 'updates a vehicle' do
      put "/v1/vehicles/#{@vehicle[:id]}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'DELETE /v1/vehicles/:id' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }

    before do
      @vehicle = create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: user.id)
    end

    it 'updates a vehicle' do
      delete "/v1/vehicles/#{@vehicle[:id]}",
        headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
