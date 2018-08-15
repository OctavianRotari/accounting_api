module Api::V1
  class SanctionsController < ApiController
    before_action :set_sanction, only: [:show, :update, :destroy]

    def index
      sanctions = current_user.sanctions
      json_response(sanctions)
    end

    def show
      json_response(@sanction)
    end

    def update
      @sanction.update(sanction_params)
      if(@sanction.save)
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def create
      begin
        sanction = current_user.sanctions.new(sanction_params)
        if sanction.save
          link_to_vehicle(sanction)
          head :created, location: v1_sanctions_url(sanction)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def destroy
      @sanction.destroy
      head :no_content
    end

    private

    def sanction_params
      params.require(:sanction).permit(
        :total,
        :date,
        :description,
        :deadline,
      )
    end

    def vehicle_param
      params.require(:sanction).permit(:vehicle_id)
    end

    def set_sanction
      @sanction = current_user.sanctions.find(params[:id])
    end

    def link_to_vehicle(sanction)
      if(vehicle_param[:vehicle_id])
        vehicle_id = vehicle_param[:vehicle_id]
        sanction.associate_to(vehicle_id)
      end
    end
  end
end
