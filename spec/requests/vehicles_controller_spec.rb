require 'rails_helper'

RSpec.describe 'Vehicle Api', type: :request do
  before :all do
    user = create(:user)
    @auth_headers = user.create_new_auth_token
  end

  describe 'GET /v1/vehicles' do
    before do
      @vehicle = create(:vehicle, :type_one)
      get '/v1/vehicles', headers: @auth_headers
    end

    it 'return vehicles for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the plate of the vehicle is correct' do
      vehicle = json[0]
      expect(vehicle['plate']).to eq('EH535RV')
    end
  end

  describe 'GET /v1/vehicles/:id' do
    before :all do
      @vehicle = create(:vehicle, :type_one)
    end

    it 'success' do
      get "/v1/vehicles/#{@vehicle.id}", headers: @auth_headers
      expect(json['plate']).to eq(@vehicle.plate)
    end
  end

  describe 'POST /v1/vehicles' do
    let(:valid_params) do
      {
        vehicle: attributes_for(:vehicle, :type_one)
      }
    end
    let(:invalid_params) do
      {
        vehicle: {
        }
      }
    end

    it 'create a vehicle' do
      expect {
        post "/v1/vehicles",
        headers: @auth_headers,
        params: valid_params
      }.to change(Vehicle, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'create a vehicle error' do
      post "/v1/vehicles", headers: @auth_headers, params: invalid_params
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: vehicle')
    end
  end

  describe 'PUT /v1/vehicles/:id' do
    let(:valid_params) do
      {
        vehicle: {
          plate: 'EH2543BX',
          roadworthiness_check_date: Date.today.at_beginning_of_month.next_month,
        }
      }
    end

    before do
      @vehicle = create(:vehicle, :type_one)
    end

    it 'updates a vehicle' do
      put "/v1/vehicles/#{@vehicle[:id]}",
        headers: @auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'DELETE /v1/vehicles/:id' do
    before do
      @vehicle = create(:vehicle, :type_one)
    end

    it 'updates a vehicle' do
      delete "/v1/vehicles/#{@vehicle[:id]}",
        headers: @auth_headers
        expect(response).to have_http_status :no_content
    end
  end

  describe 'gets all sanctions for vehicle' do
    let(:vehicle) { create(:vehicle, :type_one) }
    let(:sanction) {create(:sanction)}

    before do
      vehicle.sanctions << sanction
      get "/v1/vehicles/#{vehicle.id}/sanctions", headers: @auth_headers
    end

    it 'returns all' do
      expect(json.count).to eq(1)
    end
  end

  describe 'gets all financial_contributions for vehicle' do
    let(:financial_contribution) { create(:financial_contribution, :type_one) }
    before :all do
      @vehicle = create(:vehicle, :type_one)
    end

    before do
      @vehicle.financial_contributions << financial_contribution
      get "/v1/vehicles/#{@vehicle.id}/financial_contributions", headers: @auth_headers
    end

    it 'returns all' do
      expect(json.count).to eq(1)
    end
  end

  describe 'get all invoices for vehicle' do
    let(:vehicle) { create(:vehicle, :type_one) }
    let(:invoice) { create(:invoice) }

    before do
      vehicle.invoices << invoice
      get "/v1/vehicles/#{vehicle.id}/invoices", headers: @auth_headers
    end

    it 'returns all' do
      expect(json.count).to eq(1)
    end
  end

  describe 'insurances' do
    before :each do
      @vehicle = create(:vehicle, :type_one)
    end

    it 'gets all insurances' do
      insurance = create(:insurance, :valid)
      @vehicle.insurances << insurance 
      get "/v1/vehicles/#{@vehicle.id}/insurances", headers: @auth_headers
      expect(json.count).to eq(1)
    end

    it 'get the active insurance' do
      insurance = create(:insurance, :valid)
      insurance1 = create(:insurance, :valid, :expired)
      @vehicle.insurances << insurance 
      @vehicle.insurances << insurance1
      get "/v1/vehicles/#{@vehicle.id}/active_insurance", headers: @auth_headers
      expect(json['total']).to eq("3200.0")
    end
  end
end
