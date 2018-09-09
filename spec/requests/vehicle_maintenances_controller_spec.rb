require 'rails_helper'

RSpec.describe 'Vehicle Api', type: :request do
  let(:user) { User.first }
  let(:auth_headers) { user.create_new_auth_token }

  describe 'GET /v1/vehicles/:id/maintenances' do
    before do
      vehicle_type = create(:vehicle_type, user_id: user.id)
      vehicle = create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: user.id)
      create(:maintenance, vehicle_id: vehicle.id)
      get "/v1/vehicles/#{vehicle.id}/maintenances", headers: auth_headers
    end

    it 'return maintenances for all vehicles' do
      expect(json.count).to eq(1)
    end

    it 'checks that the address of the vendor is correct' do
      maintenance = json[0]
      expect(maintenance['desc']).to eq('olio motore')
    end
  end

  describe 'POST /v1/vehicles' do
    let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }
    let(:vehicle) { create(:vehicle, vehicle_type_id: vehicle_type.id,  user_id: user.id) }
    let(:valid_params) do
      {
        maintenance: {
          vehicle_id: vehicle.id,
          desc: 'freni',
          date: Date.today.prev_month,
        }
      }
    end

    let(:invalid_params) do
      {
        maintenance: {}
      }
    end

    it 'create a vehicle' do
      expect {
        post "/v1/vehicles/#{vehicle.id}/maintenances",
        headers: auth_headers,
        params: valid_params
      }.to change(Maintenance, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'create a vehicle error' do
      post "/v1/vehicles/#{vehicle.id}/maintenances",
        headers: auth_headers,
        params: invalid_params
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: maintenance')
    end
  end

  describe 'PUT /v1/maintenances/:id' do
    let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }
    let(:vehicle) { create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: user.id) }
    let(:valid_params) do
      {
        maintenance: {
          vehicle_id: vehicle.id,
          desc: 'freni',
          date: Date.today.prev_month,
        }
      }
    end

    before do
      @maintenance = create(:maintenance, vehicle_id: vehicle.id)
    end

    it 'updates a maintenance' do
      put "/v1/maintenances/#{@maintenance.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'DELETE /v1/vehicles/:id' do
    let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }
    let(:vehicle) { create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: user.id) }

    before do
      @maintenance = create(:maintenance, vehicle_id: vehicle.id)
    end

    it 'updates a vehicle' do
      delete "/v1/maintenances/#{@maintenance.id}",
        headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
