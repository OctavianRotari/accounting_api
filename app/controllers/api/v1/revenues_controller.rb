module Api::V1
  class RevenuesController < ApiController
    before_action :set_revenue, only: [:show, :update, :destroy]

    def update
      @revenue.update(revenue_params)
      if(@revenue.save)
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def destroy
      @revenue.destroy
      head :no_content
    end

    def show
      json_response(@revenue)
    end

    private 

    def revenue_params
      params.require(:revenue).permit(
        :total,
        :method_of_payment,
        :date,
      )
    end

    def set_revenue
      @revenue = Revenue.find(params[:id])
    end
  end
end
