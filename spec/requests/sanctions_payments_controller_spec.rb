require 'rails_helper'

RSpec.describe 'Sanction Payments Api', type: :request do
  describe 'GET /v1/sanctions/#{sanction.id}/payments' do
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }
    let(:sanction) { create(:sanction, user_id: user.id) }

    before do
      payment = attributes_for(:payment)
      sanction.payments.create(payment)
      get "/v1/sanctions/#{sanction.id}/payments", headers: auth_headers
    end

    it 'return sanctions for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the address of the vendor is correct' do
      payment = json[0]
      expect(payment['total']).to eq('100.0')
    end
  end

  # describe 'POST /v1/employees/#{employee.id}/salaries/#{salary.id}/payments' do
  #   let(:user) { create(:user) }
  #   let(:auth_headers) { user.create_new_auth_token }
  #   let(:salary) { create(:salary, employee_id: employee.id) }
  #   let(:valid_params) do
  #     {
  #       payment: {
  #         total: 1600.03,
  #         method_of_payment: 'Bonifico',
  #         date: Date.today.at_beginning_of_month.next_month,
  #       }
  #     }
  #   end

  #   let(:invalid_params) do
  #     {
  #       payment: {}
  #     }
  #   end

  #   it 'create a payments for a salary salary' do
  #     expect {
  #       post "/v1/employees/#{employee.id}/salaries/#{salary.id}/payments",
  #       headers: auth_headers,
  #       params: valid_params
  #     }.to change(Payment, :count).by(+1)
  #     expect(response).to have_http_status :created
  #   end

  #   it 'create a salary error' do
  #     post "/v1/employees/#{employee.id}/salaries/#{salary.id}/payments",
  #       headers: auth_headers,
  #       params: invalid_params
  #     expect(response).to have_http_status :unprocessable_entity
  #     expect(json['message']).to eq('param is missing or the value is empty: payment')
  #   end
  # end

  # describe 'PUT /v1/employees/#{employee.id}/salaries/:id/payments/:id' do
  #   let(:user) { create(:user) }
  #   let(:auth_headers) { user.create_new_auth_token }
  #   let(:salary) { create(:salary, employee_id: employee.id) }
  #   let(:valid_params) do
  #     {
  #       payment: {
  #         total: 1600.03,
  #         method_of_payment: 'Bonifico',
  #         date: Date.today.at_beginning_of_month.next_month,
  #       }
  #     }
  #   end

  #   before do
  #     payment = attributes_for(:payment)
  #     @payment = salary.payments.create(payment)
  #   end

  #   it 'updates a salary' do
  #     put "/v1/employees/#{employee.id}/salaries/#{salary.id}/payments/#{@payment[:id]}",
  #       headers: auth_headers,
  #       params: valid_params
  #     expect(response).to have_http_status :no_content
  #   end
  # end

  # describe 'DELETE /v1/employees/#{employee.id}/salaries/:id' do
  #   let(:user) { create(:user) }
  #   let(:auth_headers) { user.create_new_auth_token }
  #   let(:salary) { create(:salary, employee_id: employee.id) }

  #   before do
  #     payment = attributes_for(:payment)
  #     @payment = salary.payments.create(payment)
  #   end

  #   it 'updates a salary' do
  #     delete "/v1/employees/#{employee.id}/salaries/#{salary.id}/payments/#{@payment[:id]}",
  #       headers: auth_headers
  #     expect(response).to have_http_status :no_content
  #   end
  # end
end
