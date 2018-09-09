require 'rails_helper'

RSpec.describe 'Payments Api', type: :request do
  let(:user) { User.first }
  let(:auth_headers) { user.create_new_auth_token }

  describe 'SHOW /v1/payments/#{payment.id}' do
    before :each do
      @payment = create(:payment, :valid)
    end

    it 'returns the requested payment' do
      get "/v1/payments/#{@payment.id}", headers: auth_headers
      expect(json["total"]).to eq("100.0")
      expect(json["method_of_payment"]).to eq("banca")
    end
  end

  describe 'PUT /v1/payments/#{payment.id}' do
    let(:valid_params) do
      {
        payment: {
          total: 1600.03,
          method_of_payment: 'Bonifico',
          date: Date.today.at_beginning_of_month.next_month,
        }
      }
    end

    before do
      @payment = create(:payment, :valid)
    end

    it 'updates a payment' do
      put "/v1/payments/#{@payment.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'DELETE /v1/payments/#{payment.id}' do
    before do
      @payment = create(:payment, :valid)
    end

    it 'deletes a invoice' do
      delete "/v1/payments/#{@payment.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
