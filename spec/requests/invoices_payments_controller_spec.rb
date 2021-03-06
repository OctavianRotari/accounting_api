require 'rails_helper'

RSpec.describe 'Invoice Payments Api', type: :request do
  let(:user) { User.first }
  let(:auth_headers) { user.create_new_auth_token }

  describe 'GET /v1/invoices/#{invoice.id}/payments' do
    let(:vendor) { create(:vendor, user_id: user.id) }
    let(:invoice) { create(:invoice, vendor_id: vendor.id) }

    before do
      payment = attributes_for(:payment, :valid)
      invoice.payments.create(payment)
      get "/v1/invoices/#{invoice.id}/payments", headers: auth_headers
    end

    it 'return invoices for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the address of the vendor is correct' do
      payment = json[0]
      expect(payment['total']).to eq('100.0')
    end
  end

  describe 'POST /v1/invoices/#{invoice.id}/payments' do
    let(:vendor) { create(:vendor, user_id: user.id) }
    let(:invoice) { create(:invoice, vendor_id: vendor.id) }

    let(:valid_params) do
      {
        payment: {
          total: 9.00,
          method_of_payment: 'Bonifico',
          date: Date.today.at_beginning_of_month.next_month,
        }
      }
    end

    let(:invalid_params) do
      {
        payment: {}
      }
    end

    before :each do
      create(:line_item, invoice_id: invoice.id)
    end

    it 'create a payments for a invoice invoice' do
      expect {
        post "/v1/invoices/#{invoice.id}/payments",
        headers: auth_headers,
        params: valid_params
      }.to change(Payment, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'create a invoice error' do
      post "/v1/invoices/#{invoice.id}/payments",
        headers: auth_headers,
        params: invalid_params
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: payment')
    end
  end
end
