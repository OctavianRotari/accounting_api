module Api::V1
  class PaymentsController < ApiController
    before_action :set_payment, only: [:show, :update, :destroy]

    def update
      @payment.update(payment_params)
      if(@payment.save)
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def destroy
      @payment.destroy
      head :no_content
    end

    def show
      json_response(@payment)
    end

    private 

    def payment_params
      params.require(:payment).permit(
        :total,
        :method_of_payment,
        :date,
      )
    end

    def set_payment
      @payment = Payment.find(params[:id])
    end
  end
end
