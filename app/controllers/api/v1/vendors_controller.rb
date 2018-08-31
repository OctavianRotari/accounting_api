module Api::V1
  class VendorsController < ApiController
    before_action :set_vendor, only: [:show, :update, :destroy, :fuel_receipts]

    def index
      vendors = current_user.vendors
      json_response(vendors)
    end

    def create
      begin
        vendor = Vendor.new(vendors_params)
        vendor[:user_id] = current_user.id
        if vendor.save
          head :created, location: v1_other_expenses_url(vendor)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def update
      @vendor.update(vendors_params)
      if(@vendor.save) 
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def destroy
      @vendor.destroy
      head :no_content
    end

    def fuel_receipts
      json_response(@vendor.fuel_receipts)
    end

    private
    def vendors_params
      params.require(:vendor).permit(
        :address,
        :name,
        :number
      )
    end

    def set_vendor
      @vendor = Vendor.find(params[:id])
    end
  end
end
