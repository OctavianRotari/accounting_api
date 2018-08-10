module Api::V1
  class VendorsController < ApiController
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
      vendor.update(vendors_params)
      if(vendor.save) 
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def destroy
      vendor.destroy
      head :no_content
    end

    private
    def vendors_params
      params.require(:vendor).permit(
        :address,
        :name,
        :number
      )
    end

    def vendor
      current_user.vendors.find_by(id: params[:id])
    end
  end
end
