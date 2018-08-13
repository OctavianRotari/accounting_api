module Api::V1
  class SanctionsPaymentsController < ApiController
    def index
      payments = sanction.payments
      json_response(payments)
    end

    def create
      begin
        payment = sanction.create_payment(hash_payment)
        if payment
          head :created, location: v1_sanction_payments_url(payment)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    private
    def payment_params
      params.require(:payment).permit(
        :total,
        :method_of_payment,
        :date,
      )
    end

    def sanction
      current_user.sanctions.find(params[:sanction_id])
    end

    def hash_payment
      {
        total: payment_params['total'],
        method_of_payment: payment_params['method_of_payment'],
        date: payment_params['date']
      }
    end
  end
end
