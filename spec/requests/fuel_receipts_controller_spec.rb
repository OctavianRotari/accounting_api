require 'rails_helper'

RSpec.describe 'FuelReceipts Api', type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }
  let(:vendor) { create(:vendor, user_id: user.id) }
  let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }
  let(:vehicle) { create(:vehicle, user_id: user.id, vehicle_type_id: vehicle_type.id) }

  describe 'GET /v1/vehicles/#{vehicle.id}/fuel_receipts' do
    before do
      create(:fuel_receipt, vendor_id: vendor.id, vehicle_id: vehicle.id)
      get "/v1/vehicles/#{vehicle.id}/fuel_receipts", headers: auth_headers
    end

    it 'returns all fuel receipts for vendor' do
      expect(json.count).to eq(1)
    end

    it 'checks that the total of the first other expense is correct' do
      fuel_receipt = json[0]
      expect(fuel_receipt['total']).to eq('230.0')
    end
  end

  describe 'POST /v1/vehicles/#{vehicle.id}/fuel_receipts' do
    let(:valid_params) do
      {
        fuel_receipt: {
          litres: 230,
          total: 10.3,
          date: Date.today(),
          vendor_id: vendor.id,
        }
      }
    end

    let(:invalid_params) do
      { fuel_receipt: {} }
    end

    it 'creates fuel_receipts' do
      expect {
        post "/v1/vehicles/#{vehicle.id}/fuel_receipts",
        headers: auth_headers,
        params: valid_params
      }.to change(FuelReceipt, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates invoice error' do
      post "/v1/vehicles/#{vehicle.id}/fuel_receipts",
      headers: auth_headers,
      params: invalid_params 
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: fuel_receipt')
    end
  end

  describe 'PUT /v1/fuel_receipt/#{fuel_receipt.id}' do
    let(:fuel_receipt) { create(:fuel_receipt, vendor_id: vendor.id, vehicle_id: vehicle.id) }
    let(:valid_params) do
      {
        fuel_receipt: {
          litres: 230,
          total: 10.3,
          date: Date.today(),
          vendor_id: vendor.id,
        }
      }
    end

    it 'updates fuel_receipt' do
      put "/v1/fuel_receipts/#{fuel_receipt.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'SHOW /v1/fuel_receipt/#{fuel_receipt.id}' do
    let(:fuel_receipt) { create(:fuel_receipt, vendor_id: vendor.id, vehicle_id: vehicle.id) }

    it 'gets fuel receipt' do
      get "/v1/fuel_receipts/#{fuel_receipt.id}", headers: auth_headers
      expect(json["total"]).to eq("230.0")
    end
  end

  describe 'Delete /v1/fuel_receipt' do
    let(:fuel_receipt) { create(:fuel_receipt, vendor_id: vendor.id, vehicle_id: vehicle.id) }

    it 'deletes fuel_receipt' do
      delete "/v1/fuel_receipts/#{fuel_receipt.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
