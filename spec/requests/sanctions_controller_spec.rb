RSpec.describe 'sanction Api', type: :request do
  let(:user) { User.first }
  let(:auth_headers) { user.create_new_auth_token }

  describe 'GET /v1/sanctions' do
    before do
      create(:sanction, user_id: user.id)
      get '/v1/sanctions', headers: auth_headers
    end

    it 'return sanctions for user' do
      expect(json.count).to eq(1)
    end

    it 'checks that the address of the vendor is correct' do
      sanction = json[0]
      expect(sanction['total']).to eq('1600.22')
    end
  end

  describe 'POST /v1/sanctions' do
    let(:valid_params) do
      {
        sanction: {
          total: 1600,
          date: Date.today.last_month.beginning_of_month,
          deadline: Date.today + 5
        }
      }
    end
    let(:invalid_params) do
      {
        sanction: {}
      }
    end

    it 'create a sanction' do
      expect {
        post "/v1/sanctions",
        headers: auth_headers,
        params: valid_params
      }.to change(Sanction, :count).by(+1)
      expect(response).to have_http_status :created
    end

    it 'create a sanction error' do
      post "/v1/sanctions",
        headers: auth_headers,
        params: invalid_params
      expect(response).to have_http_status :unprocessable_entity
      expect(json['message']).to eq('param is missing or the value is empty: sanction')
    end

    describe 'POST a vehicle finacial contribution' do
      let(:vehicle_type) { create(:vehicle_type, user_id: user.id) }

      before do
        @vehicle = create(:vehicle, vehicle_type_id: vehicle_type.id, user_id: user.id)
      end

      let(:valid_params) do
        {
          sanction: {
            total: 1600,
            date: Date.today.last_month.beginning_of_month,
            deadline: Date.today + 5,
            vehicle_id: @vehicle.id,
          }
        }
      end

      it 'creates sanction vehicle' do
        vehicle = Vehicle.all.find(@vehicle.id)
        expect {
          post '/v1/sanctions',
          headers: auth_headers,
          params: valid_params
        }.to change(Sanction, :count).by(+1)
        expect(vehicle.sanctions).to eq(Sanction.all)
        expect(response).to have_http_status :created
      end
    end
  end

  describe 'PUT /v1/sanctions/:id' do
    let(:valid_params) do
      {
        sanction: {
          total: 'Gianni',
          date: Date.today + 5,
          description: 'autista, multa'
        }
      }
    end

    before do
      @sanction = create(:sanction, user_id: user.id)
    end

    it 'updates a sanction' do
      put "/v1/sanctions/#{@sanction[:id]}",
        headers: auth_headers,
        params: valid_params
      expect(response).to have_http_status :no_content
    end
  end

  describe 'DELETE /v1/sanctions/:id' do
    before do
      @sanction = create(:sanction, user_id: user.id)
    end

    it 'updates a sanction' do
      delete "/v1/sanctions/#{@sanction[:id]}",
        headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
