module Api::V1
  class VehicleTypesController < ApiController
    def index
      @vehicle_types = current_user.vehicle_types
      json_response(@vehicle_types)
    end

    def update
      vehicle_type = current_user.vehicle_types.find_by(id: params[:id])
      vehicle_type.update(vehicle_type_params)
      if(vehicle_type.save) 
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def create
      begin
        vehicle_type = current_user.vehicle_types.new(vehicle_type_params)
        if vehicle_type.save
          head :created, location: v1_vehicle_types_url(vehicle_type)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    private

    def vehicle_type_params
      params.require(:vehicle_type).permit(:desc)
    end
  end
end
