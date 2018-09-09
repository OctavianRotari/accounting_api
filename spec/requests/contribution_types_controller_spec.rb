require 'rails_helper'

RSpec.describe 'Other expenses Api', type: :request do
  let(:user) { User.first }
  let(:auth_headers) { user.create_new_auth_token }

  describe 'GET /v1/contribution_types' do
    before do
      create(:contribution_type, user_id: user.id)
      get '/v1/contribution_types', headers: auth_headers
    end

    it 'return other one other expense for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the total of the first other expense is correct' do
      contribution_type = json[0]
      expect(contribution_type['desc']).to eq('MyString')
    end
  end

  describe 'POST /v1/contribution_types' do
    let(:valid_params) do
      {
        contribution_type: {
          desc: 'IVA',
        }
      }
    end

    let(:invalid_params) do
      { contribution_type: {} }
    end

    it 'creates other expense' do
      expect {
        post '/v1/contribution_types',
        headers: auth_headers,
        params: valid_params
      }.to change(ContributionType, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates invoice error' do
      post '/v1/contribution_types',
      headers: auth_headers,
      params: invalid_params 
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: contribution_type')
    end
  end

  describe 'PUT /v1/contribution_type' do
    let(:contribution_type) { create(:contribution_type, user_id: user.id) }
    let(:valid_params) do
      {
        contribution_type: {
          desc: 'IRPA',
        }
      }
    end

    it 'updates contribution_type' do
      put "/v1/contribution_types/#{contribution_type.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'Delete /v1/contribution_type' do
    let(:contribution_type) { create(:contribution_type, user_id: user.id) }

    it 'deletes contribution_type' do
      delete "/v1/contribution_types/#{contribution_type.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
