module Api::V1
  class VehiclesController < ApiController
    def index
      @vehicles = current_user.vehicles
      json_response(@vehicles)
    end

    def update
      vehicle = current_user.vehicles.find_by(id: params[:id])
      vehicle.update(vehicle_params)
      if(vehicle.save)
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def create
      begin
        vehicle = current_user.vehicles.new(vehicle_params)
        if vehicle.save
          head :created, location: v1_vehicle_types_url(vehicle)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    private

    def vehicle_params
      params.require(:vehicle).permit(
        :plate,
        :charge_general_expenses,
        :roadworthiness_check_date,
        :vehicle_type_id
      )
    end
  end
end
