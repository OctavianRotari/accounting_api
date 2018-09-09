require 'rails_helper'

RSpec.describe 'Invoices Api', type: :request do
  let(:user) { User.first }
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
        }
      }
    end

    let(:invalid_params) do
      { invoice: {} }
    end

    it 'creates' do
      expect {
        post "/v1/vendors/#{vendor.id}/invoices",
        headers: auth_headers,
        params: valid_params
      }.to change(Invoice, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates error' do
      post "/v1/vendors/#{vendor.id}/invoices",
        headers: auth_headers,
        params: invalid_params
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: invoice')
    end

    describe 'line_items' do
      let(:valid_params) do
        {
          invoice: {
            date: Date.today(),
            deadline: Date.today.next_month(),
            description: 'Pezzi di ricambio',
            serial_number: '324321',
          },
          line_items: [attributes_for(:line_item), attributes_for(:line_item)],
        }
      end

      it 'creates line_items' do
        expect {
          post "/v1/vendors/#{vendor.id}/invoices",
          headers: auth_headers,
          params: valid_params
        }.to change(Invoice, :count).by(+1)
        expect(LineItem.all.count).to eq(2)
        expect(response).to have_http_status :created
      end
    end

    describe 'line_items fuel_receipt' do
      let(:vendor) { create(:vendor, user_id: user.id) }
      let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }
      let(:vehicle) { create(:vehicle, user_id: user.id, vehicle_type_id: vehicle_type.id) }
      let(:fuel_receipt) { create(:fuel_receipt, vendor_id: vendor.id, vehicle_id: vehicle.id) }
      let(:fuel_receipt_1) { create(:fuel_receipt, vendor_id: vendor.id, vehicle_id: vehicle.id) }
      let(:valid_params) do
        {
          invoice: {
            date: Date.today(),
            deadline: Date.today.next_month(),
            description: 'Pezzi di ricambio',
            serial_number: '324321',
          },
          fuel_receipts_ids: [fuel_receipt.id, fuel_receipt_1.id],
        }
      end

      it 'creates line_items' do
        expect {
          post "/v1/vendors/#{vendor.id}/invoices",
          headers: auth_headers,
          params: valid_params
        }.to change(Invoice, :count).by(+1)
        expect(LineItem.all.count).to eq(2)
        expect(response).to have_http_status :created
      end
    end

    describe 'vehicle' do
      let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }
      let(:vehicle) { create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: user.id) }
      let(:valid_params_vehicle) do
        {
          invoice: {
            date: Date.today(),
            deadline: Date.today.next_month(),
            description: 'Pezzi di ricambio',
            serial_number: '324321',
            vehicle_id: vehicle.id,
          }
        }
      end

      before :each do
        @vehicle = vehicle
      end

      it 'links to invoice on create' do
        vehicle = Vehicle.find(@vehicle.id)
        post "/v1/vendors/#{vendor.id}/invoices",
          headers: auth_headers,
          params: valid_params_vehicle
        expect(response).to have_http_status :created
        expect(vehicle.invoices).to eq(Invoice.all)
      end
    end
  end

  describe 'SHOW /v1/invoice' do
    let(:invoice) { create(:invoice, vendor_id: vendor.id) }

    it 'returns the invoice with line items' do
      get "/v1/invoices/#{invoice.id}", headers: auth_headers
      expect(json['description']).to eq("Pezzi di ricambio")
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
        invoice: {}
      }
    end

    it 'updates invoice' do
      put "/v1/invoices/#{invoice.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'Delete /v1/invoice' do
    let(:invoice) { create(:invoice, vendor_id: vendor.id) }

    it 'deletes invoice' do
      delete "/v1/invoices/#{invoice.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
