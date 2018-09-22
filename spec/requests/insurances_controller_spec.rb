require 'rails_helper'

RSpec.describe 'Insurances Api', type: :request do
  let(:user) { User.first }
  let(:auth_headers) { user.create_new_auth_token }
  let(:vendor) { create(:vendor, user_id: user.id) }

  describe 'GET /v1/vendor/#{vendor.id}/insurances' do
    before do
      create(:insurance, :valid, vendor_id: vendor.id)
      get "/v1/vendors/#{vendor.id}/insurances", headers: auth_headers
    end

    it 'returns all insurances for a vendor' do
      expect(json.count).to eq(1)
    end

    it 'checks that the total of the first insurance is correct' do
      insurances = json[0]
      expect(insurances['total']).to eq("3200.0")
    end
  end

  describe 'Post /v1/vendors/#{vendor.id}/insurances' do
    let(:valid_params) do
      {
        insurance: attributes_for(:insurance, :valid, vendor_id: vendor.id)
      }
    end

    let (:invalid_params) do
      { insurance: {} }
    end

    it 'creates insurance' do
      expect {
        post "/v1/vendors/#{vendor.id}/insurances",
        headers: auth_headers,
        params: valid_params
      }.to change(Insurance, :count).by(+1)
    end

    it 'create insurance error' do
      post "/v1/vendors/#{vendor.id}/insurances",
        headers: auth_headers,
        params: invalid_params
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: insurance')
    end

    describe 'vehicle' do
      let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }
      let(:vehicle) { create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: user.id) }
      let(:valid_params_vehicle) do
        {
          insurance: attributes_for(:insurance, :valid, vendor_id: vendor.id)
        }
      end

      before :each do
        @vehicle = vehicle
        valid_params_vehicle[:insurance][:vehicle_id] = vehicle.id
      end

      it 'links to vehicle on create' do
        post "/v1/vendors/#{vendor.id}/insurances",
          headers: auth_headers,
          params: valid_params_vehicle
        expect(response).to have_http_status :created
        expect(vehicle.insurances).to eq([Insurance.last])
      end
    end
  end

  describe 'Put /v1/insurances/#{insurance.id}' do
    let(:insurance) { create(:insurance, :valid, vendor_id: vendor.id) }
    let(:valid_params) do
      {
        insurance: attributes_for(:insurance, :put, vendor_id: vendor.id)
      }
    end

    it 'updates insurance' do
      put "/v1/insurances/#{insurance.id}", headers: auth_headers, params: valid_params
      expect(Insurance.find(insurance.id)['total'].to_f).to eq(3400.00)
    end
  end

  describe 'show /v1/insurances/#{insurance.id}' do
    let(:insurance) { create(:insurance, :valid, vendor_id: vendor.id) }

    it 'show insurance' do
      get "/v1/insurances/#{insurance.id}", headers: auth_headers
      expect(json['total'].to_f).to eq(insurance.total)
    end
  end

  describe 'delete /v1/insurances/#{insurance.id}' do
    let(:insurance) { create(:insurance, :valid, vendor_id: vendor.id) }

    it 'deletes insurance' do
      delete "/v1/insurances/#{insurance.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
