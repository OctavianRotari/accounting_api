require 'rails_helper'

RSpec.describe 'Other expenses Api', type: :request do
  describe 'GET /v1/other_expenses' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }

    before do
      create(:other_expense, user_id: user.id)
      get '/v1/other_expenses', headers: auth_headers
    end

    it 'return other one other expense for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the total of the first other expense is correct' do
      other_expense = json[0]
      expect(other_expense['total']).to eq('10.3')
    end
  end

  describe 'POST /v1/other_expenses' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:valid_params) do
      {
        other_expense: {
          desc: 'caffe',
          total: 10.3,
          date: Date.today(),
        }
      }
    end

    let(:invalid_params) do
      { other_expense: {} }
    end

    it 'creates other expense' do
      expect {
        post '/v1/other_expenses',
        headers: auth_headers,
        params: valid_params
      }.to change(OtherExpense, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates invoice error' do
      post '/v1/other_expenses',
      headers: auth_headers,
      params: invalid_params 
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: other_expense')
    end
  end

  describe 'PUT /v1/other_expense' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:other_expense) { create(:other_expense, user_id: user.id) }
    let(:valid_params) do
      {
        other_expense: {
          desc: 'caffe',
          total: 10.3,
          date: Date.today(),
        }
      }
    end

    it 'updates other_expense' do
      put "/v1/other_expenses/#{other_expense.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'Delete /v1/other_expense' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:other_expense) { create(:other_expense, user_id: user.id) }

    it 'deletes other_expense' do
      delete "/v1/other_expenses/#{other_expense.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
