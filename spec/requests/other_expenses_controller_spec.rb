require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Other expenses Api', type: :request do
  before :all do
    if(User.all.count == 0)
      user = create(:user)
    else
      user = User.find_by(uid: 'octavianrotari@example.com')
    end
    @auth_headers = user.create_new_auth_token
  end

  describe 'GET /v1/other_expenses' do
    before do
      create(:other_expense)
      get '/v1/other_expenses', headers: @auth_headers
    end

    it 'return other one other expense for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the total of the first other expense is correct' do
      other_expense = json[0]
      expect(other_expense['total']).to eq('10.3')
    end

    it 'empty array if other user' do
      user = create(:user_one)
      auth_headers = user.create_new_auth_token
      get '/v1/other_expenses', headers: auth_headers
      expect(json.count).to eq(0)
    end
  end

  describe 'POST /v1/other_expenses' do
    let(:valid_params) do
      {
        desc: 'caffe',
        total: 10.3,
        date: Date.today(),
      }
    end

    let(:invalid_params) do
      { }
    end

    it 'creates other expense' do
      expect {
        post '/v1/other_expenses',
        headers: @auth_headers,
        params: valid_params
      }.to change(OtherExpense, :count).by(+1)
      expect(response).to have_http_status :created
    end
  end

  describe 'PUT /v1/other_expense' do
    let(:other_expense) { create(:other_expense) }
    let(:valid_params) do
      {
        desc: 'caffe',
        total: 10.3,
        date: Date.today(),
      }
    end

    it 'updates other_expense' do
      put "/v1/other_expenses/#{other_expense.id}",
        headers: @auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'Delete /v1/other_expense' do
    let(:other_expense) { create(:other_expense) }

    it 'deletes other_expense' do
      delete "/v1/other_expenses/#{other_expense.id}", headers: @auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
