require 'rails_helper'

RSpec.describe 'Vendors Api', type: :request do
  describe 'GET /v1/vendors' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }

    before do
      create(:vendor, user_id: user.id)
      get '/v1/vendors', headers: auth_headers
    end

    it 'return vendors for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the address of the vendor is correct' do
      vendor = json[0]
      expect(vendor['address']).to eq('5 fowler terrace')
    end
  end

  describe 'POST /v1/vendors' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:valid_params) do
      {
        vendor: {
          address: '5 fowler terrace',
          name: 'Taste something',
          number: '+4335425432',
        }
      }
    end

    let(:invalid_params) do
      { vendor: {} }
    end

    it 'creates other expense' do
      expect {
        post '/v1/vendors',
        headers: auth_headers,
        params: valid_params
      }.to change(Vendor, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates invoice error' do
      post '/v1/vendors',
      headers: auth_headers,
      params: invalid_params 
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: vendor')
    end
  end

  describe 'PUT /v1/vendor' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:vendor) { create(:vendor, user_id: user.id) }
    let(:valid_params) do
      {
        vendor: {
          address: '5 fowler terrace',
          name: 'Taste something',
          number: '+4335425432',
        }
      }
    end

    it 'updates vendor' do
      put "/v1/vendors/#{vendor.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'Delete /v1/vendor' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:vendor) { create(:vendor, user_id: user.id) }

    it 'deletes vendor' do
      delete "/v1/vendors/#{vendor.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
