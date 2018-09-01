module Api::V1
  class LoadsController < ApiController 
    before_action :set_load, only: [:show, :update, :destroy]

    def index
      loads = Vehicle.find(vehicle_id).loads
      json_response(loads)
    end

    def update
      @load.update(load_params)
      if(@load.save)
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def create
      begin
        load = Load.new(load_params)
        load[:vehicle_id] = vehicle_id
        if load.save
          head :created, locatin: v1_fuel_receipt_url(load)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def show
      json_response(@load)
    end

    def destroy
      @load.destroy
      head :no_content
    end

    private

    def vehicle_id
      params[:vehicle_id]
    end

    def load_params
      params.require(:load).permit(
        :from,
        :to,
        :serial_number,
        :weight,
        :date,
        :desc,
        :price,
        :vendor_id,
      )
    end

    def set_load
      @load = Load.find(params[:id])
    end
  end
end
