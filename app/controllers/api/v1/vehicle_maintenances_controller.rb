module Api::V1
  class VehicleMaintenancesController < ApiController
    before_action :set_maintenance, only: [:show, :update, :destroy]

    def index
      json_response(vehicle.maintenances)
    end

    def update
      @maintenance.update(maintenances_params)
      if(@maintenance.save)
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def create
      begin
        maintenance = vehicle.maintenances.new(maintenances_params)
        if maintenance.save
          head :created, location: v1_vehicle_maintenances_url(maintenance)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def destroy
      @maintenance.destroy
      head :no_content
    end

    private

    def maintenances_params
      params.require(:maintenance).permit(
        :date,
        :deadline,
        :desc,
        :km
      )
    end

    def vehicle
      current_user.vehicles.find_by(id: params[:vehicle_id])
    end

    def set_maintenance
      @maintenance = Maintenance.find(params[:id])
    end
  end
end
