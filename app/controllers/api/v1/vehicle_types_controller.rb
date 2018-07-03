module Api::V1
  class VehicleTypesController < ApiController
    def index
      @vehicle_types = current_user.vehicle_types
      json_response(@vehicle_types)
    end
  end
end
