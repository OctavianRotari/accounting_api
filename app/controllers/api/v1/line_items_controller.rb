module Api::V1
  class LineItemsController < ApiController 
    before_action :set_line_item, only: [:show, :update, :destroy]

    def update
      @line_item.update(line_item_params)
      if(@line_item.save)
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def show
      json_response(@line_item)
    end

    def destroy
      @line_item.destroy
      head :no_content
    end

    private
    def line_item_params
      params.require(:line_item).permit(
        :total,
        :vat,
        :description,
      )
    end

    def set_line_item
      @line_item = LineItem.find(params[:id])
    end
  end
end
