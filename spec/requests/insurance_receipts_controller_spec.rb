require 'rails_helper'

RSpec.describe 'InsuranceReceipts Api', type: :request do
  before :all do
    if(User.all.count == 0)
      user = create(:user)
    else
      user = User.find_by(uid: 'octavianrotari@example.com')
    end
    @auth_headers = user.create_new_auth_token
  end

  describe 'GET /v1/insurances/#{insurance.id}/insurance_receipts' do
    before do
      insurance = create(:insurance, :valid)
      create(:insurance_receipt, :valid, insurance_id: insurance.id)
      get "/v1/insurances/#{insurance.id}/insurance_receipts", headers: @auth_headers
    end

    it 'return other one other expense for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the total of the first other expense is correct' do
      insurance_receipt = json[0]
      expect(insurance_receipt['total']).to eq("100.0")
    end
  end

  describe 'POST /v1/insurance_receipts' do
    let(:valid_params) do
      {
        insurance_receipt: attributes_for(:insurance_receipt, :valid)
      }
    end

    let(:invalid_params) do
      { insurance_receipt: {} }
    end

    before :all do
      @insurance = create(:insurance, :valid)
    end

    it 'creates insurance_receipts' do
      expect {
        post "/v1/insurances/#{@insurance.id}/insurance_receipts",
        headers: @auth_headers,
        params: valid_params
      }.to change(InsuranceReceipt, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates invoice error' do
      post "/v1/insurances/#{@insurance.id}/insurance_receipts",
      headers: @auth_headers,
      params: invalid_params 
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: insurance_receipt')
    end
  end

  describe 'PUT /v1/insurance_receipt' do
    before :all do
      @insurance = create(:insurance, :valid)
      @insurance_receipt = create(:insurance_receipt, :valid, insurance_id: @insurance.id)
      @valid_params = {
        insurance_receipt: {
          total: 20.00,
        }
      }
      @invalid_params = {
        insurance_receipt: {
          total: 2000.00,
        }
      }
    end

    it 'updates insurance_receipt' do
      put "/v1/insurance_receipts/#{@insurance_receipt.id}",
        headers: @auth_headers,
        params: @valid_params
      expect(response).to have_http_status :no_content
    end

    it 'updates insurance_receipt error'do
      put "/v1/insurance_receipts/#{@insurance_receipt.id}",
        headers: @auth_headers,
        params: @invalid_params
      expect(json['messages']).to eq(["Total Total too big"])
    end
  end

  describe 'Delete /v1/insurance_receipt' do
    before :all do
      @insurance = create(:insurance, :valid)
      @insurance_receipt = create(:insurance_receipt, :valid, insurance_id: @insurance.id)
    end

    it 'deletes insurance_receipt' do
      delete "/v1/insurance_receipts/#{@insurance_receipt.id}", headers: @auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
