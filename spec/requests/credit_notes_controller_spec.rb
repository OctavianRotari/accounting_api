require 'rails_helper'

RSpec.describe 'CreditNotes Api', type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }
  let(:vendor) { create(:vendor, user_id: user.id) }

  describe 'GET /v1/vendors/#{vendor.id}/credit_notes' do
    before do
      create(:credit_note, vendor_id: vendor.id)
      get "/v1/vendors/#{vendor.id}/credit_notes", headers: auth_headers
    end

    it 'returns all fuel receipts for vendor' do
      expect(json.count).to eq(1)
    end

    it 'checks that the total of the first other expense is correct' do
      credit_note = json[0]
      expect(credit_note['total']).to eq("100.0")
    end
  end

  describe 'POST /v1/vendors/#{vendor.id}/credit_notes' do
    let(:valid_params) do
      {
        credit_note: build(:credit_note, vendor_id: vendor.id).as_json
      }
    end

    let(:invalid_params) do
      { credit_note: {} }
    end

    it 'creates credit_notes' do
      expect {
        post "/v1/vendors/#{vendor.id}/credit_notes",
        headers: auth_headers,
        params: valid_params
      }.to change(CreditNote, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'creates invoice error' do
      post "/v1/vendors/#{vendor.id}/credit_notes",
      headers: auth_headers,
      params: invalid_params 
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: credit_note')
    end
  end

  describe 'PUT /v1/credit_note/#{credit_note.id}' do
    let(:credit_note) { create(:credit_note, vendor_id: vendor.id) }
    let(:valid_params) do
      {
        credit_note: build(:credit_note, vendor_id: vendor.id).as_json
      }
    end

    it 'updates credit_note' do
      put "/v1/credit_notes/#{credit_note.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'SHOW /v1/credit_note/#{credit_note.id}' do
    let(:credit_note) { create(:credit_note, vendor_id: vendor.id) }

    it 'gets fuel receipt' do
      get "/v1/credit_notes/#{credit_note.id}", headers: auth_headers
      expect(json["total"]).to eq("100.0")
    end
  end

  describe 'Delete /v1/credit_note' do
    let(:credit_note) { create(:credit_note, vendor_id: vendor.id) }

    it 'deletes credit_note' do
      delete "/v1/credit_notes/#{credit_note.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
