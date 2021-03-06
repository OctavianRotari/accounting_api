require 'rails_helper'

RSpec.describe 'employee Api', type: :request do
  before :all do
    if(User.all.count == 0)
      user = create(:user)
    else
      user = User.find_by(uid: 'octavianrotari@example.com')
    end
    @auth_headers = user.create_new_auth_token
  end

  describe 'GET /v1/employees' do
    before do
      create(:employee)
      get '/v1/employees', headers: @auth_headers
    end

    it 'return employees for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the address of the vendor is correct' do
      employee = json[0]
      expect(employee['name']).to eq('Luigi')
    end

    it 'empty array if other user' do
      user = create(:user_one)
      auth_headers = user.create_new_auth_token
      get '/v1/employees', headers: auth_headers
      expect(json.count).to eq(0)
    end
  end

  describe 'POST /v1/employees' do
    let(:valid_params) do
      {
        employee: {
          name: 'Gianni',
          contract_start_date: Date.today.at_beginning_of_month,
          role: 'autista'
        }
      }
    end
    let(:invalid_params) do
      {
        employee: {}
      }
    end

    it 'create a employee' do
      expect {
        post "/v1/employees",
        headers: @auth_headers,
        params: valid_params
      }.to change(Employee, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'create a employee error' do
      post "/v1/employees",
        headers: @auth_headers,
        params: invalid_params
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: employee')
    end
  end

  describe 'PUT /v1/employees/:id' do
    let(:valid_params) do
      {
        employee: {
          name: 'Gianni',
          contract_start_date: Date.today.at_beginning_of_month,
          role: 'autista'
        }
      }
    end

    before do
      @employee = create(:employee)
    end

    it 'updates a employee' do
      put "/v1/employees/#{@employee[:id]}",
        headers: @auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'DELETE /v1/employees/:id' do
    before do
      @employee = create(:employee)
    end

    it 'updates a employee' do
      delete "/v1/employees/#{@employee[:id]}",
        headers: @auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
