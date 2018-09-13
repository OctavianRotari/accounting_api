require 'rails_helper'

RSpec.describe 'ActiveInvoices Api', type: :request do
  let(:user) { User.first }
  let(:auth_headers) { user.create_new_auth_token }
  let(:vendor) { create(:vendor, user_id: user.id) }

  describe 'GET /v1/active_invoices' do
    before do
      create(:active_invoice, vendor_id: vendor.id)
      get "/v1/vendors/#{vendor.id}/active_invoices", headers: auth_headers
    end

    it 'return active_invoices for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the address of the active_invoice is correct' do
      active_invoice = json[0]
      expect(active_invoice['serial_number']).to eq('2341gh')
    end
  end

  describe 'POST /v1/vendors/#{vendor.id}/active_invoices' do
    let(:valid_params) do
      {
        active_invoice: attributes_for(:active_invoice)
      }
    end

    let(:invalid_params) do
      { active_invoice: {} }
    end

    it 'creates' do
      expect {
        post "/v1/vendors/#{vendor.id}/active_invoices",
        headers: auth_headers,
        params: valid_params
      }.to change(ActiveInvoice, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates error' do
      post "/v1/vendors/#{vendor.id}/active_invoices",
        headers: auth_headers,
        params: invalid_params
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: active_invoice')
    end

    describe 'sold_line_items' do
      let(:valid_params) do
        {
          active_invoice: attributes_for(:active_invoice),
          sold_line_items: [attributes_for(:sold_line_item), attributes_for(:sold_line_item)],
        }
      end

      it 'creates sold_line_items' do
        expect {
          post "/v1/vendors/#{vendor.id}/active_invoices",
          headers: auth_headers,
          params: valid_params
        }.to change(ActiveInvoice, :count).by(+1)
        expect(SoldLineItem.all.count).to eq(2)
        expect(response).to have_http_status :created
      end
    end
  end

  describe 'SHOW /v1/active_invoice' do
    let(:active_invoice) { create(:active_invoice, vendor_id: vendor.id) }
    it 'returns the active_invoice with line items' do
      get "/v1/active_invoices/#{active_invoice.id}", headers: auth_headers
      expect(json['description']).to eq("I bought something")
    end
  end

  describe 'PUT /v1/active_invoice' do
    let(:active_invoice) { create(:active_invoice, vendor_id: vendor.id) }
    let(:valid_params) do
      {
        active_invoice: {
          date: Date.today(),
          deadline: Date.today.next_month(),
          description: 'Ricambio',
          serial_number: '324321',
        }
      }
    end
    let(:not_valid_params) do
      {
        active_invoice: {}
      }
    end

    it 'updates active_invoice' do
      put "/v1/active_invoices/#{active_invoice.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'Delete /v1/active_invoice' do
    let(:active_invoice) { create(:active_invoice, vendor_id: vendor.id) }

    it 'deletes active_invoice' do
      delete "/v1/active_invoices/#{active_invoice.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
