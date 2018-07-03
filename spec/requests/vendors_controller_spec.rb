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
      expect(vendor['adress']).to eq('5 fowler terrace')
    end
  end
end