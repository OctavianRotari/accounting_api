require 'rails_helper'

RSpec.describe 'FinancialContributions Api', type: :request do
  describe 'GET /v1/financial_contributions' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }

    before do
      contribution_type = create(:contribution_type, user_id: user.id)
      financial_contribution = create(:financial_contribution, contribution_type_id: contribution_type.id, user_id: user.id)
      get '/v1/financial_contributions', headers: auth_headers
    end

    it 'return other one other expense for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the total of the first other expense is correct' do
      financial_contribution = json[0]
      expect(financial_contribution['total']).to eq('10.3')
    end
  end

  describe 'POST /v1/financial_contributions' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:contribution_type) { create(:contribution_type, user_id: user.id) }
    let(:valid_params) do
      {
        financial_contribution: {
          desc: 'caffe',
          total: 10.3,
          date: Date.today(),
          contribution_type_id: contribution_type.id,
        }
      }
    end

    let(:invalid_params) do
      { financial_contribution: {} }
    end

    it 'creates financial_contributions' do
      expect {
        post '/v1/financial_contributions',
        headers: auth_headers,
        params: valid_params
      }.to change(FinancialContribution, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates invoice error' do
      post '/v1/financial_contributions',
      headers: auth_headers,
      params: invalid_params 
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: financial_contribution')
    end

    describe 'POST a vehicle finacial contribution' do
      let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }

      before do
        @vehicle = create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: user.id)
      end

      let(:valid_params) do
        {
          financial_contribution: {
            desc: 'caffe',
            total: 10.3,
            date: Date.today(),
            vehicle_id: @vehicle.id,
            contribution_type_id: contribution_type.id,
          }
        }
      end

      it 'creates financial_contributions vehicle' do
        vehicle = Vehicle.all.find(@vehicle.id)
        expect {
          post '/v1/financial_contributions',
          headers: auth_headers,
          params: valid_params
        }.to change(FinancialContribution, :count).by(+1)
        expect(vehicle.financial_contributions).to eq(FinancialContribution.all)
        expect(response).to have_http_status :created
      end
    end
  end

  describe 'PUT /v1/financial_contribution' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:contribution_type) { create(:contribution_type, user_id: user.id) }
    let(:financial_contribution) { create(:financial_contribution, contribution_type_id: contribution_type.id, user_id: user.id) }
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
      put "/v1/financial_contributions/#{financial_contribution.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'Delete /v1/financial_contribution' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:contribution_type) { create(:contribution_type, user_id: user.id) }
    let(:financial_contribution) { create(:financial_contribution, contribution_type_id: contribution_type.id, user_id: user.id) }

    it 'deletes financial_contribution' do
      delete "/v1/financial_contributions/#{financial_contribution.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end

    describe 'vehicle_contribution' do
      let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }

      before :each do
        @vehicle = create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: user.id)
        @financial_contribution = create(:financial_contribution, contribution_type_id: contribution_type.id, user_id: user.id) 
        @financial_contribution.vehicles << @vehicle
      end

      it 'deletes the related vehicle_contribution' do 
        delete "/v1/financial_contributions/#{@financial_contribution.id}", headers: auth_headers
        expect(response).to have_http_status :no_content
        expect(@vehicle.financial_contributions).to eq([])
        expect(FinancialContribution.all).to eq([])
      end
    end
  end
end
