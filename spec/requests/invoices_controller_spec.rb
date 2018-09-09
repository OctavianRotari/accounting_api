require 'rails_helper'

RSpec.describe 'Invoices Api', type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }
  let(:vendor) { create(:vendor, user_id: user.id) }

  describe 'GET /v1/invoices' do
    before do
      create(:invoice, :items, vendor_id: vendor.id)
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
          items: [{vat: 1, amount: '9.99', description: 'bulloni'}]
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

    describe 'fuel_receipts as line_items' do
      let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }
      let(:vehicle) { create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: user.id) }

      before :each do
        fuel_receipt = create(:fuel_receipt, vendor_id: vendor.id, vehicle_id: vehicle.id)
        fuel_receipt2 = create(:fuel_receipt, vendor_id: vendor.id, vehicle_id: vehicle.id)
        @valid_params = {
          invoice: {
            date: Date.today(),
            deadline: Date.today.next_month(),
            description: 'Pezzi di ricambio',
            serial_number: '324321',
            items: [fuel_receipt, fuel_receipt2]
          }
        }
      end

      it 'creates a line item for each fuel_receipt passed' do
        expect {
          post "/v1/vendors/#{vendor.id}/invoices",
          headers: auth_headers,
          params: @valid_params
        }.to change(LineItem, :count).by(+2)
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
            items: [{vat: 1, amount: '9.99', description: 'bulloni'}]
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
    let(:invoice) { create(:invoice, :items, vendor_id: vendor.id) }

    it 'returns the invoice with line items' do
      get "/v1/invoices/#{invoice.id}", headers: auth_headers
      expect(json['description']).to eq("Pezzi di ricambio")
      expect(json['line_items'].length).to eq(2)
    end
  end

  describe 'PUT /v1/invoice' do
    let(:invoice) { create(:invoice, :items, vendor_id: vendor.id) }
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
    let(:invoice) { create(:invoice, :items, vendor_id: vendor.id) }

    it 'deletes invoice' do
      delete "/v1/invoices/#{invoice.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end

    it 'deletes errors' do
      delete "/v1/invoices/#{22}", headers: auth_headers
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq("undefined method `destroy' for nil:NilClass")
    end

    describe 'Delete /v1/invoices/:invoice_id/line_item/:id' do
      let(:line_item) { create(:line_item, invoice_id: invoice.id) }

      it 'deletes line items' do
        create(:line_item, invoice_id: invoice.id)
        delete "/v1/invoices/#{invoice.id}/line_item/#{line_item.id}", headers: auth_headers
        expect(response).to have_http_status :no_content
        expect(LineItem.where(id: line_item['id'])).to eq([])
      end

      it 'deletes line items' do
        first_line_item = Invoice.find(invoice.id).line_items.first
        LineItem.delete(first_line_item.id)
        delete "/v1/invoices/#{invoice.id}/line_item/#{line_item.id}", headers: auth_headers
        expect(response).to have_http_status :unprocessable_entity
        expect(json['message']).to eq('Invoice should have at leat one line item')
      end
    end
  end

  describe 'fuel_receipts' do
    let(:invoice) { create(:invoice, :items, user_id: user.id) }
    let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }
    let(:vehicle) { create(:vehicle, user_id: user.id, vehicle_type_id: vehicle_type.id) }

    before :each do
      invoice2 = create(:invoice, :items, user_id: user.id)
      @fuel_receipt1 = create(:fuel_receipt, invoice_id: invoice2.id, vehicle_id: vehicle.id)
      @fuel_receipt2 = create(:fuel_receipt, invoice_id: invoice.id, vehicle_id: vehicle.id)
      @fuel_receipt3 = create(:fuel_receipt, invoice_id: invoice.id, vehicle_id: vehicle.id)
    end

    it 'gets all' do
      get "/v1/invoices/#{invoice.id}/fuel_receipts", headers: auth_headers
      expect(json.count).to eq(2)
    end
  end
end
