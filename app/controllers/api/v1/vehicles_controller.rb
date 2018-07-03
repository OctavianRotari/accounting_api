module Api::V1
  class VehiclesController < ApiController
    def index
      @vehicles = current_user.vehicles
      json_response(@vehicles)
    end
  end
end
