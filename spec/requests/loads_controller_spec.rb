require 'rails_helper'

RSpec.describe 'Loads Api', type: :request do
  let(:user) { User.first }
  let(:auth_headers) { user.create_new_auth_token }
  let(:vendor) { create(:vendor, user_id: user.id) }
  let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }
  let(:vehicle) { create(:vehicle, user_id: user.id, vehicle_type_id: vehicle_type.id) }

  describe 'GET /v1/vehicles/#{vehicle.id}/loads' do
    before do
      create(:load, vendor_id: vendor.id, vehicle_id: vehicle.id)
      get "/v1/vehicles/#{vehicle.id}/loads", headers: auth_headers
    end

    it 'returns all fuel receipts for vendor' do
      expect(json.count).to eq(1)
    end

    it 'checks that the total of the first other expense is correct' do
      load = json[0]
      expect(load['price']).to eq("300.2")
    end
  end

  describe 'POST /v1/vehicles/#{vehicle.id}/loads' do
    let(:valid_params) do
      {
        load: build(:load, vendor_id: vendor.id).as_json
      }
    end

    let(:invalid_params) do
      { load: {} }
    end

    it 'creates loads' do
      expect {
        post "/v1/vehicles/#{vehicle.id}/loads",
        headers: auth_headers,
        params: valid_params
      }.to change(Load, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates invoice error' do
      post "/v1/vehicles/#{vehicle.id}/loads",
      headers: auth_headers,
      params: invalid_params 
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: load')
    end
  end

  describe 'PUT /v1/load/#{load.id}' do
    let(:load) { create(:load, vendor_id: vendor.id, vehicle_id: vehicle.id) }
    let(:valid_params) do
      {
        load: build(:load, vendor_id: vendor.id).as_json
      }
    end

    it 'updates load' do
      put "/v1/loads/#{load.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'SHOW /v1/load/#{load.id}' do
    let(:load) { create(:load, vendor_id: vendor.id, vehicle_id: vehicle.id) }

    it 'gets fuel receipt' do
      get "/v1/loads/#{load.id}", headers: auth_headers
      expect(json["price"]).to eq("300.2")
    end
  end

  describe 'Delete /v1/load' do
    let(:load) { create(:load, vendor_id: vendor.id, vehicle_id: vehicle.id) }

    it 'deletes load' do
      delete "/v1/loads/#{load.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
