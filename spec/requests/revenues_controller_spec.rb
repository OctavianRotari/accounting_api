require 'rails_helper'

RSpec.describe 'Revenues Api', type: :request do
  let(:user) { User.first }
  let(:auth_headers) { user.create_new_auth_token }

  describe 'SHOW /v1/revenues/#{revenue.id}' do
    before :each do
      @revenue = create(:revenue)
    end

    it 'returns the requested revenue' do
      get "/v1/revenues/#{@revenue.id}", headers: auth_headers
      expect(json["total"]).to eq("100.0")
      expect(json["method_of_payment"]).to eq("banca")
    end
  end

  describe 'PUT /v1/revenues/#{revenue.id}' do
    let(:valid_params) do
      {
        revenue: {
          total: 1600.03,
          method_of_revenue: 'Bonifico',
          date: Date.today.at_beginning_of_month.next_month,
        }
      }
    end

    before do
      @revenue = create(:revenue)
    end

    it 'updates a revenue' do
      put "/v1/revenues/#{@revenue.id}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'DELETE /v1/revenues/#{revenue.id}' do
    before do
      @revenue = create(:revenue)
    end

    it 'deletes a invoice' do
      delete "/v1/revenues/#{@revenue.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
