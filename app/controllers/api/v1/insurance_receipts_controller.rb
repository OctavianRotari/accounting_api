module Api::V1
  class InsuranceReceiptsController < ApiController
    before_action :set_insurance_receipt, only: [:show, :update, :destroy]

    def index
      insurance = Insurance.find(params[:insurance_id])
      insurance_receipts = insurance.insurance_receipts
      json_response(insurance_receipts)
    end

    def show
      insurance_receipt = @insurance_receipt.as_json
      json_response(insurance_receipt)
    end

    def create
      begin
        insurance_receipt = InsuranceReceipt.new(insurance_receipt_params)
        insurance_receipt.insurance_id = params[:insurance_id]
        if insurance_receipt.save
          head :created, location: v1_insurance_receipt_url(insurance_receipt)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def update
      begin
        @insurance_receipt.update(insurance_receipt_params)
        if(@insurance_receipt.save)
          head :no_content
        else
          json_response({messages: @insurance_receipt.errors.full_messages}, :unprocessable_entity)
        end
      rescue => e
        json_response({messages: e}, :unprocessable_entity)
      end
    end

    def destroy
      begin
        @insurance_receipt.destroy
        head :no_content
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    private
    def insurance_receipt_params
      params.require(:insurance_receipt).permit(
        :date,
        :total,
        :method_of_payment,
      )
    end

    def set_insurance_receipt
      @insurance_receipt = InsuranceReceipt.find(params[:id])
    end
  end
end
