require 'rails_helper'

RSpec.describe 'LineItem Api', type: :request do
  let(:user) { User.first }
  let(:auth_headers) { user.create_new_auth_token }
  let(:invoice) {create(:invoice, :items)}

  describe 'PUT /v1/line_item/#{line_item.id}' do
    let(:valid_params) do
      {
        line_item: {
          vat: 23,
          total: 10.3,
        }
      }
    end

    it 'updates line_item' do
      line_item = invoice.line_items.first
      put "/v1/line_items/#{line_item.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
      expect(invoice.line_items.first["total"].to_s).to eq("10.3")
    end
  end

  describe 'SHOW /v1/line_item/#{line_item.id}' do
    it 'gets line_item' do
      line_item = invoice.line_items.first
      get "/v1/line_items/#{line_item.id}", headers: auth_headers
      expect(json["total"]).to eq("9.99")
    end
  end

  describe 'Delete /v1/line_item' do
    it 'deletes line_item' do
      line_item = invoice.line_items.first
      delete "/v1/line_items/#{line_item.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
