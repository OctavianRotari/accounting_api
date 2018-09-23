require 'rails_helper'

RSpec.describe 'Vehicle Api', type: :request do
  before :all do
    if(User.all.count == 0)
      user = create(:user)
    else
      user = User.find_by(uid: 'octavianrotari@example.com')
    end
    @auth_headers = user.create_new_auth_token
    @vehicle = create(:vehicle, user_id: user.id)
  end

  describe 'GET /v1/vehicles' do
    before :each do
      user2 = create(:user_one)
      create(:vehicle, user_id: user2.id)
      get '/v1/vehicles', headers: @auth_headers
    end

    it 'return vehicles for user' do
      expect(json.count).to eq(Vehicle.all.count - 1)
    end

    it 'checks that the plate of the vehicle is correct' do
      vehicle = json.last
      expect(vehicle['plate']).to eq(@vehicle[:plate])
    end
  end

  describe 'GET /v1/vehicles/:id' do
    it 'success' do
      get "/v1/vehicles/#{@vehicle.id}", headers: @auth_headers
      expect(json['plate']).to eq(@vehicle.plate)
    end
  end

  describe 'POST /v1/vehicles' do
    let(:valid_params) do
      {
        vehicle: attributes_for(:vehicle)
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

    it 'updates a vehicle' do
      put "/v1/vehicles/#{@vehicle[:id]}",
        headers: @auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'DELETE /v1/vehicles/:id' do
    it 'updates a vehicle' do
      delete "/v1/vehicles/#{@vehicle[:id]}",
        headers: @auth_headers
        expect(response).to have_http_status :no_content
    end
  end

  describe 'gets all sanctions for vehicle' do
    before :each do
      sanction = create(:sanction)
      @vehicle.sanctions << sanction
      get "/v1/vehicles/#{@vehicle.id}/sanctions", headers: @auth_headers
    end

    it 'returns all' do
      expect(json.count).to eq(1)
    end
  end

  describe 'gets all financial_contributions for vehicle' do
    before :each do
      financial_contribution = create(:financial_contribution)
      @vehicle = create(:vehicle)
      @vehicle.financial_contributions << financial_contribution
      get "/v1/vehicles/#{@vehicle.id}/financial_contributions", headers: @auth_headers
    end

    it 'returns all' do
      expect(json.count).to eq(1)
    end
  end

  describe 'get all invoices for vehicle' do
    before :each do
      invoice = create(:invoice)
      @vehicle.invoices << invoice
      get "/v1/vehicles/#{@vehicle.id}/invoices", headers: @auth_headers
    end

    it 'returns all' do
      expect(json.count).to eq(1)
    end
  end

  describe 'insurances' do
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
