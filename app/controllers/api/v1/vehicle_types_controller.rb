module Api::V1
  class VehicleTypesController < ApiController
    before_action :set_vehicle_type, only: [:update]

    def index
      json_response(VehicleType.all)
    end

    def update
      @vehicle_type.update(vehicle_type_params)
      if(@vehicle_type.save) 
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def create
      begin
        vehicle_type = VehicleType.new(vehicle_type_params)
        vehicle_type[:user_id] = current_user.id
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

    def set_vehicle_type
      @vehicle_type = VehicleType.find(params[:id])
    end
  end
end
