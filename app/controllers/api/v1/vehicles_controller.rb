module Api::V1
  class VehiclesController < ApiController
    before_action :set_vehicle, only: [:show, :update, :destroy, :sanctions, :financial_contributions, :invoices]

    def index vehicles = current_user.vehicles
      json_response(vehicles)
    end

    def sanctions
      json_response(@vehicle.sanctions)
    end

    def financial_contributions
      json_response(@vehicle.financial_contributions)
    end

    def invoices
      json_response(@vehicle.invoices)
    end

    def show
      json_response(@vehicle)
    end

    def update
      @vehicle.update(vehicle_params)
      if(@vehicle.save)
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def create
      begin
        vehicle = current_user.vehicles.new(vehicle_params)
        if vehicle.save
          head :created, location: v1_vehicle_url(vehicle)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def destroy
      @vehicle.destroy
      head :no_content
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

    def set_vehicle
      @vehicle = current_user.vehicles.find(params[:id])
    end
  end
end
