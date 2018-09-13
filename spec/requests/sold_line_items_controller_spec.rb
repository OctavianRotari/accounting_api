require 'rails_helper'

RSpec.describe 'SoldLineItem Api', type: :request do
  let(:user) { User.first }
  let(:auth_headers) { user.create_new_auth_token }
  let(:active_invoice) {create(:active_invoice, :sold_items)}

  describe 'PUT /v1/sold_line_item/#{sold_line_item.id}' do
    let(:valid_params) do
      {
        sold_line_item: {
          vat: 23,
          total: 10.3,
        }
      }
    end

    it 'updates sold_line_item' do
      sold_line_item = active_invoice.sold_line_items.first
      put "/v1/sold_line_items/#{sold_line_item.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
      expect(active_invoice.sold_line_items.first["total"].to_s).to eq("10.3")
    end
  end

  describe 'SHOW /v1/sold_line_item/#{sold_line_item.id}' do
    it 'gets sold_line_item' do
      sold_line_item = active_invoice.sold_line_items.first
      get "/v1/sold_line_items/#{sold_line_item.id}", headers: auth_headers
      expect(json["total"]).to eq("1000.0")
    end
  end

  describe 'Delete /v1/sold_line_item' do
    it 'deletes sold_line_item' do
      sold_line_item = active_invoice.sold_line_items.first
      delete "/v1/sold_line_items/#{sold_line_item.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
