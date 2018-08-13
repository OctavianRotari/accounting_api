module Api::V1
  class SalariesPaymentsController < ApiController
    def index
      payments = salary.payments
      json_response(payments)
    end

    def create
      begin
        payment = salary.create_payment(hash_payment)
        if payment
          head :created, location: v1_salary_payments_url(payment)
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

    def salary
      Salary.find(params[:salary_id])
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
