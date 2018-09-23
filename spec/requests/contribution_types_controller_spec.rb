require 'rails_helper'

RSpec.describe 'Other expenses Api', type: :request do
  before :all do
    if(User.all.count == 0)
      user = create(:user)
    else
      user = User.find_by(uid: 'octavianrotari@example.com')
    end
    @auth_headers = user.create_new_auth_token
  end

  describe 'GET /v1/contribution_types' do
    before do
      get '/v1/contribution_types', headers: @auth_headers
    end

    it 'return other one other expense for user' do
      expect(json.count).to eq(24)
    end

    it 'checks that the total of the first other expense is correct' do
      create(:contribution_type)
      get '/v1/contribution_types', headers: @auth_headers
      contribution_type = json.last
      expect(contribution_type['desc']).to eq('My Contribution')
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
        headers: @auth_headers,
        params: valid_params
      }.to change(ContributionType, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates invoice error' do
      post '/v1/contribution_types',
      headers: @auth_headers,
      params: invalid_params 
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: contribution_type')
    end
  end

  describe 'PUT /v1/contribution_type' do
    let(:contribution_type) { create(:contribution_type) }
    let(:valid_params) do
      {
        contribution_type: {
          desc: 'IRPA',
        }
      }
    end

    it 'updates contribution_type' do
      put "/v1/contribution_types/#{contribution_type.id}",
        headers: @auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'Delete /v1/contribution_type' do
    let(:contribution_type) { create(:contribution_type) }

    it 'deletes contribution_type' do
      delete "/v1/contribution_types/#{contribution_type.id}", headers: @auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
