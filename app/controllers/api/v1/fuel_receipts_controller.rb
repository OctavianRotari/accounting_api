module Api::V1
  class FuelReceiptsController < ApiController 
    before_action :set_fuel_receipt, only: [:show, :update, :destroy]

    def index
      fuel_receipts = Vehicle.find(vehicle_id).fuel_receipts
      json_response(fuel_receipts)
    end

    def update
      @fuel_receipt.update(fuel_receipt_params)
      if(@fuel_receipt.save)
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def create
      begin
        fuel_receipt = FuelReceipt.new(fuel_receipt_params)
        fuel_receipt[:vehicle_id] = vehicle_id
        if fuel_receipt.save
          head :created, locatin: v1_fuel_receipt_url(fuel_receipt)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def show
      json_response(@fuel_receipt)
    end

    def destroy
      @fuel_receipt.destroy
      head :no_content
    end

    private

    def vehicle_id
      params[:vehicle_id]
    end

    def fuel_receipt_params
      params.require(:fuel_receipt).permit(
        :total,
        :date,
        :litres,
        :vendor_id,
      )
    end

    def set_fuel_receipt
      @fuel_receipt = FuelReceipt.find(params[:id])
    end
  end
end
