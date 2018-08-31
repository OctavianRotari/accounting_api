require 'rails_helper'

RSpec.describe 'Invoices Api', type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }
  let(:vendor) { create(:vendor, user_id: user.id) }

  describe 'GET /v1/invoices' do
    before do
      create(:invoice, vendor_id: vendor.id)
      get "/v1/vendors/#{vendor.id}/invoices", headers: auth_headers
    end

    it 'return invoices for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the address of the invoice is correct' do
      invoice = json[0]
      expect(invoice['serial_number']).to eq('09243vs')
    end
  end

  describe 'POST /v1/vendors/#{vendor.id}/invoices' do
    let(:valid_params) do
      {
        invoice: {
          date: Date.today(),
          deadline: Date.today.next_month(),
          description: 'Pezzi di ricambio',
          serial_number: '324321',
          line_items: [{vat: 1, amount: '9.99', description: 'bulloni'}]
        }
      }
    end

    let(:invalid_params) do
      { invoice: {} }
    end

    it 'creates other expense' do
      expect {
        post "/v1/vendors/#{vendor.id}/invoices",
        headers: auth_headers,
        params: valid_params
      }.to change(Invoice, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates invoice error' do
      post "/v1/vendors/#{vendor.id}/invoices",
      headers: auth_headers,
      params: invalid_params 
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: invoice')
    end
  end

  describe 'PUT /v1/invoice' do
    let(:invoice) { create(:invoice, vendor_id: vendor.id) }
    let(:valid_params) do
      {
        invoice: {
          date: Date.today(),
          deadline: Date.today.next_month(),
          description: 'Ricambio',
          serial_number: '324321',
        }
      }
    end
    let(:not_valid_params) do
      {
        invoice: {
          line_items: []
        }
      }
    end

    it 'updates invoice' do
      put "/v1/invoices/#{invoice.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end

    it 'fails if line_items empty' do
      put "/v1/invoices/#{invoice.id}",
        headers: auth_headers,
        params: not_valid_params
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('Line items cannot be empty')
    end

    it 'updates line items too' do
      line_item = create(:line_item, invoice_id: invoice.id)
      line_item = line_item.as_json
      line_item['description'] = 'Rondelle'
      valid_params = {
        invoice: {
          line_items: [line_item.as_json]
        }
      }
      put "/v1/invoices/#{invoice.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
      expect(LineItem.find(line_item['id'])['description']).to eq('Rondelle')
    end
  end

  describe 'Delete /v1/invoice' do
    let(:invoice) { create(:invoice, vendor_id: vendor.id) }

    it 'deletes invoice' do
      delete "/v1/invoices/#{invoice.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end

  # describe 'fuel_receipts' do
  #   let(:invoice) { create(:invoice, user_id: user.id) }
  #   let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }
  #   let(:vehicle) { create(:vehicle, user_id: user.id, vehicle_type_id: vehicle_type.id) }

  #   before :each do
  #     invoice2 = create(:invoice, user_id: user.id)
  #     create(:fuel_receipt, invoice_id: invoice2.id, vehicle_id: vehicle.id)
  #     create(:fuel_receipt, invoice_id: invoice.id, vehicle_id: vehicle.id)
  #     create(:fuel_receipt, invoice_id: invoice.id, vehicle_id: vehicle.id)
  #   end

  #   it 'gets all' do
  #     get "/v1/invoices/#{invoice.id}/fuel_receipts", headers: auth_headers
  #     expect(json.count).to eq(2)
  #   end
  # end
end
