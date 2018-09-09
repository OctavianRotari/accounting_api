require 'rails_helper'

RSpec.describe 'ActiveInvoiceRevenues Api', type: :request do
  let(:user) { User.first }
  let(:auth_headers) { user.create_new_auth_token }
  let(:vendor) { create(:vendor, user_id: user.id) }
  let(:active_invoice) { create(:active_invoice, vendor_id: vendor.id) }

  describe 'GET /v1/active_invoices/#{active_invoice.id}/revenues' do
    before do
      revenue = attributes_for(:revenue)
      active_invoice.revenues.create(revenue)
      get "/v1/active_invoices/#{active_invoice.id}/revenues", headers: auth_headers
    end

    it 'return active_invoices for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the address of the vendor is correct' do
      revenue = json[0]
      expect(revenue['total']).to eq('100.0')
    end
  end

  describe 'POST /v1/active_invoices/#{active_invoice.id}/revenues' do
    let(:valid_params) do
      {
        revenue: {
          total: 9.00,
          method_of_payment: 'Bonifico',
          date: Date.today.at_beginning_of_month.next_month,
        }
      }
    end

    let(:invalid_params) do
      {
        revenue: {}
      }
    end

    before :each do
      create(:sold_line_item, active_invoice_id: active_invoice.id)
    end

    it 'create a revenues for a active_invoice active_invoice' do
     expect {
        post "/v1/active_invoices/#{active_invoice.id}/revenues",
        headers: auth_headers,
        params: valid_params
      }.to change(Revenue, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'create a active_invoice error' do
      post "/v1/active_invoices/#{active_invoice.id}/revenues",
        headers: auth_headers,
        params: invalid_params
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: revenue')
    end
  end
end
