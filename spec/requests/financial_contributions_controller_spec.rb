require 'rails_helper'

RSpec.describe 'FinancialContributions Api', type: :request do
  before :all do
    if(User.all.count == 0)
      user = create(:user)
    else
      user = User.find_by(uid: 'octavianrotari@example.com')
    end
    @auth_headers = user.create_new_auth_token
    @financial_contribution = create(:financial_contribution)
  end

  describe 'GET /v1/financial_contributions' do
    before :all do
      get '/v1/financial_contributions', headers: @auth_headers
    end

    it 'checks that the total of the first other expense is correct' do
      financial_contribution = json.last
      expect(financial_contribution['total'].to_f).to eq(@financial_contribution[:total].to_f)
    end
  end

  describe 'POST /v1/financial_contributions' do
    let(:valid_params) do
      {
        financial_contribution: attributes_for(:financial_contribution)
      }
    end

    let(:invalid_params) do
      { financial_contribution: {} }
    end

    it 'creates financial_contributions' do
      expect {
        post '/v1/financial_contributions',
        headers: @auth_headers,
        params: valid_params
      }.to change(FinancialContribution, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates invoice error' do
      post '/v1/financial_contributions',
      headers: @auth_headers,
      params: invalid_params 
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: financial_contribution')
    end

    describe 'POST a vehicle finacial contribution' do
      before do
        @vehicle = create(:vehicle)
      end

      let(:valid_params) do
        {
          financial_contribution: attributes_for(:financial_contribution)
        }
      end

      it 'creates financial_contributions vehicle' do
        vehicle = Vehicle.all.find(@vehicle.id)
        valid_params[:financial_contribution]['vehicle_id'] = vehicle.id
        expect {
          post '/v1/financial_contributions',
          headers: @auth_headers,
          params: valid_params
        }.to change(FinancialContribution, :count).by(+1)
        expect(vehicle.financial_contributions).to eq(Vehicle.find(@vehicle.id).financial_contributions)
        expect(response).to have_http_status :created
      end
    end
  end

  describe 'PUT /v1/financial_contribution' do
    let(:valid_params) do
      {
        financial_contribution: {
          desc: 'IVA trimestrale',
          total: 2000.00,
          date: Date.today(),
        }
      }
    end

    it 'updates financial_contribution' do
      put "/v1/financial_contributions/#{@financial_contribution.id}",
        headers: @auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'Delete /v1/financial_contribution' do
    it 'deletes financial_contribution' do
      delete "/v1/financial_contributions/#{@financial_contribution.id}", headers: @auth_headers
      expect(response).to have_http_status :no_content
    end

    describe 'vehicle_contribution' do
      before :each do
        @vehicle = create(:vehicle)
        @financial_contribution.vehicles << @vehicle
      end

      it 'deletes the related vehicle_contribution' do 
        delete "/v1/financial_contributions/#{@financial_contribution.id}", headers: @auth_headers
        expect(response).to have_http_status :no_content
        expect(@vehicle.financial_contributions).to eq([])
      end
    end
  end
end
