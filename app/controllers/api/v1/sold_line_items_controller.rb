module Api::V1
  class SoldLineItemsController < ApiController 
    before_action :set_sold_line_item, only: [:show, :update, :destroy]

    def update
      @sold_line_item.update(sold_line_item_params)
      if(@sold_line_item.save)
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def show
      json_response(@sold_line_item)
    end

    def destroy
      @sold_line_item.destroy
      head :no_content
    end

    private
    def sold_line_item_params
      params.require(:sold_line_item).permit(
        :total,
        :vat,
        :description,
      )
    end

    def set_sold_line_item
      @sold_line_item = SoldLineItem.find(params[:id])
    end
  end
end
