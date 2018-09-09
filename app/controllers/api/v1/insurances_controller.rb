module Api::V1
  class InsurancesController < ApiController
    before_action :set_insurance, only: [:show, :update, :destroy]

    def index
      vendor = Vendor.find(params[:vendor_id])
      insurances = vendor.insurances
      json_response(insurances)
    end

    def create
      begin
        insurance = Insurance.new(insurance_params)
        insurance.vendor_id = params[:vendor_id]
        if insurance.save
          link_to_vehicle(insurance)
          head :created, location: v1_insurance_url(insurance)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def show
      json_response(@insurance)
    end

    def update
      begin
        @insurance.update(insurance_params)
        if(@insurance.save)
          head :no_content
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def destroy
      begin
        @insurance.destroy
        head :no_content
      rescue => e
        e
      end
    end

    private

    def insurance_params
      params.require(:insurance).permit(
        :date,
        :deadline,
        :description,
        :total,
        :serial_of_contract,
        :payment_recurrence,
      )
    end

    def set_insurance
      begin
        @insurance = Insurance.find(params[:id])
      rescue => e
        e
      end
    end

    def vehicle_param
      params.require(:insurance).permit(
        :vehicle_id
      )
    end

    def link_to_vehicle(insurance)
      if(vehicle_param[:vehicle_id])
        vehicle_id = vehicle_param[:vehicle_id]
        insurance.associate_to(vehicle_id)
      end
    end
  end
end
