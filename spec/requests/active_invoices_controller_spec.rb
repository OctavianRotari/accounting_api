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
        active_invoice: {
          date: Date.today(),
          deadline: Date.today.next_month(),
          description: 'Pezzi di ricambio',
          serial_number: '324321',
          sold_line_items: [{vat: 1, total: '9.99', description: 'bulloni'}]
        }
      }
    end

    let(:invalid_params) do
      { active_invoice: {} }
    end

    it 'creates other expense' do
      expect {
        post "/v1/vendors/#{vendor.id}/active_invoices",
        headers: auth_headers,
        params: valid_params
      }.to change(ActiveInvoice, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates active_invoice error' do
      post "/v1/vendors/#{vendor.id}/active_invoices",
        headers: auth_headers,
        params: invalid_params 
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: active_invoice')
    end
  end

  describe 'SHOW /v1/active_invoice' do
    let(:active_invoice) { create(:active_invoice, vendor_id: vendor.id) }

    it 'returns the active_invoice with line items' do
      get "/v1/active_invoices/#{active_invoice.id}", headers: auth_headers
      expect(json['description']).to eq("I bought something")
      expect(json['sold_line_items'].length).to eq(1)
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
        active_invoice: {
          sold_line_items: []
        }
      }
    end

    it 'updates active_invoice' do
      put "/v1/active_invoices/#{active_invoice.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end

    it 'updates line items too' do
      sold_line_item = create(:sold_line_item, active_invoice_id: active_invoice.id)
      sold_line_item = sold_line_item.as_json
      sold_line_item['description'] = 'Rondelle'
      valid_params = {
        active_invoice: {
          sold_line_items: [sold_line_item.as_json]
        }
      }
      put "/v1/active_invoices/#{active_invoice.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
      expect(SoldLineItem.find(sold_line_item['id'])['description']).to eq('Rondelle')
    end
  end

  describe 'Delete /v1/active_invoice' do
    let(:active_invoice) { create(:active_invoice, vendor_id: vendor.id) }

    it 'deletes active_invoice' do
      delete "/v1/active_invoices/#{active_invoice.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end

    it 'deletes errors' do
      delete "/v1/active_invoices/#{22}", headers: auth_headers
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq("undefined method `destroy' for nil:NilClass")
    end
  end

  # describe 'fuel_receipts' do
  #   let(:active_invoice) { create(:active_invoice, user_id: user.id) }
  #   let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }
  #   let(:vehicle) { create(:vehicle, user_id: user.id, vehicle_type_id: vehicle_type.id) }

  #   before :each do
  #     invoice2 = create(:active_invoice, user_id: user.id)
  #     create(:fuel_receipt, invoice_id: invoice2.id, vehicle_id: vehicle.id)
  #     create(:fuel_receipt, invoice_id: active_invoice.id, vehicle_id: vehicle.id)
  #     create(:fuel_receipt, invoice_id: active_invoice.id, vehicle_id: vehicle.id)
  #   end

  #   it 'gets all' do
  #     get "/v1/active_invoices/#{active_invoice.id}/fuel_receipts", headers: auth_headers
  #     expect(json.count).to eq(2)
  #   end
  # end
end
