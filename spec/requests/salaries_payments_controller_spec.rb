require 'rails_helper'

RSpec.describe 'Salary Api', type: :request do
  # describe 'GET /v1/employees/#{employee.id}/salaries' do
  #   let(:user) { create(:user) }
  #   let(:auth_headers) { user.create_new_auth_token }

  #   before do
  #     employee = create(:employee, user_id: user.id)
  #     create(:salary, employee_id: employee.id)
  #     employee = create(:employee, user_id: user.id)
  #     salary = create(:salary, employee_id: employee.id)
  #     payment = create(:payment)
  #     salary.create_payment(payment)
  #     get "/v1/employees/#{employee.id}/salaries", headers: auth_headers
  #   end

  #   it 'return salaries for user' do
  #     employee = create(:employee, user_id: user.id)
  #     @salary = create(:salary, employee_id: employee.id)
  #     payment = create(:payment)
  #     @salary.create_payment(payment)
  #     byebug
  #     expect(json.count).to eq(1)
  #   end

  #   it 'checks that the address of the vendor is correct' do
  #     salary = json[0]
  #     expect(salary['total']).to eq('1600.22')
  #   end
  # end

  describe 'POST /v1/employees/#{employee.id}/salaries/#{salary.id}/payments' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:employee) { create(:employee, user_id: user.id) }
    let(:salary) { create(:salary, employee_id: employee.id) }
    let(:valid_params) do
      {
        payment: {
          total: 1600.03,
          method_of_payment: 'Bonifico',
          date: Date.today.at_beginning_of_month.next_month,
        }
      }
    end
    let(:invalid_params) do
      {
        salary: {}
      }
    end

    it 'create a salary' do
      expect {
        post "/v1/employees/#{employee.id}/salaries/#{salary.id}/payments",
        headers: auth_headers,
        params: valid_params
      }.to change(Payment, :count).by(+1)
      expect(response).to have_http_status :created
    end

    # it 'create a salary error' do
    #   post "/v1/employees/#{employee.id}/salaries",
    #     headers: auth_headers,
    #     params: invalid_params
    #   expect(response).to have_http_status :unprocessable_entity
    #   expect(json['message']).to eq('param is missing or the value is empty: salary')
    # end
  end

  # describe 'PUT /v1/employees/#{employee.id}/salaries/:id' do
  #   let(:user) { create(:user) }
  #   let(:auth_headers) { user.create_new_auth_token }
  #   let(:employee) { create(:employee, user_id: user.id) }
  #   let(:valid_params) do
  #     {
  #       salary: {
  #         employee_id: employee.id,
  #         total: 1600.03,
  #         month: Date.today.at_beginning_of_month.next_month,
  #         deadline: Date.today.at_beginning_of_month.next_month,
  #       }
  #     }
  #   end

  #   before do
  #     @salary = create(:salary, employee_id: employee.id)
  #   end

  #   it 'updates a salary' do
  #     put "/v1/employees/#{employee.id}/salaries/#{@salary[:id]}",
  #       headers: auth_headers,
  #       params: valid_params
  #     expect(response).to have_http_status :no_content
  #   end
  # end

  # describe 'DELETE /v1/employees/#{employee.id}/salaries/:id' do
  #   let(:user) { create(:user) }
  #   let(:auth_headers) { user.create_new_auth_token }
  #   let(:employee) { create(:employee, user_id: user.id) }

  #   before do
  #     @salary = create(:salary, employee_id: employee.id)
  #   end

  #   it 'updates a salary' do
  #     delete "/v1/employees/#{employee.id}/salaries/#{@salary[:id]}",
  #       headers: auth_headers
  #     expect(response).to have_http_status :no_content
  #   end
  # end
end
