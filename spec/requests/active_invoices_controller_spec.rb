require 'rails_helper'

RSpec.describe 'ActiveInvoices Api', type: :request do
  before :all do
    if(User.all.count == 0)
      user = create(:user)
    else
      user = User.find_by(uid: 'octavianrotari@example.com')
    end
    @auth_headers = user.create_new_auth_token
    @vendor = create(:vendor)
    @active_invoice = create(:active_invoice)
  end

  describe 'GET /v1/active_invoices' do
    before :each do
      get "/v1/vendors/#{@active_invoice.vendor.id}/active_invoices", headers: @auth_headers
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
    before :all do
      @valid_params = {
        active_invoice: attributes_for(:active_invoice)
      }
      @invalid_params = { active_invoice: {} }
    end

    it 'creates' do
      expect {
        post "/v1/vendors/#{@vendor.id}/active_invoices",
        headers: @auth_headers,
        params: @valid_params
      }.to change(ActiveInvoice, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates error' do
      post "/v1/vendors/#{@vendor.id}/active_invoices",
        headers: @auth_headers,
        params: @invalid_params
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: active_invoice')
    end

    describe 'sold_line_items' do
      before :all do
        @valid_params_item = {
          active_invoice: attributes_for(:active_invoice),
          sold_line_items: [attributes_for(:sold_line_item), attributes_for(:sold_line_item)],
        }
      end

      it 'creates sold_line_items' do
        expect {
          post "/v1/vendors/#{@vendor.id}/active_invoices",
          headers: @auth_headers,
          params: @valid_params_item
        }.to change(ActiveInvoice, :count).by(+1)
        expect(ActiveInvoice.last.sold_line_items.count).to eq(2)
        expect(response).to have_http_status :created
      end
    end

    describe 'sold_line_items loads' do
      before :all do
        load = create(:load)
        load_one = create(:load)
        @valid_params = {
            active_invoice: attributes_for(:active_invoice),
            loads_ids: [load.id, load_one.id],
          }
      end

      it 'creates sold_line_item' do
        expect {
          post "/v1/vendors/#{@vendor.id}/active_invoices",
          headers: @auth_headers,
          params: @valid_params
        }.to change(ActiveInvoice, :count).by(+1)
        expect(ActiveInvoice.last.sold_line_items.count).to eq(2)
        expect(response).to have_http_status :created
      end
    end
  end

  describe 'SHOW /v1/active_invoice' do
    it 'returns the active_invoice with line items' do
      get "/v1/active_invoices/#{@active_invoice.id}", headers: @auth_headers
      expect(json['description']).to eq("I bought something")
    end
  end

  describe 'PUT /v1/active_invoice' do
    before :all do
      @valid_params = {
        active_invoice: {
          date: Date.today(),
          deadline: Date.today.next_month(),
          description: 'Ricambio',
          serial_number: '324321',
        }
      }
      @invalid_params = { active_invoice: {} }
    end

    it 'updates active_invoice' do
      put "/v1/active_invoices/#{@active_invoice.id}",
        headers: @auth_headers,
        params: @valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'Delete /v1/active_invoice' do
    it 'deletes active_invoice' do
      delete "/v1/active_invoices/#{@active_invoice.id}", headers: @auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
