module Api::V1
  class InvoicesPaymentsController < ApiController
    before_action :set_payment, only: [:show, :update, :destroy]

    def index
      payments = invoice.payments
      json_response(payments)
    end

    def update
      payment.update(payment_params)
      if(payment.save)
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def create
      begin
        payment = invoice.create_payment(hash_payment)
        if payment
          head :created, location: v1_invoices_payments_url(payment)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def destroy
      @payment.destroy
      head :no_content
    end

    private
    def payment_params
      params.require(:payment).permit(
        :total,
        :method_of_payment,
        :date,
      )
    end

    def invoice
      Invoice.find(params[:invoice_id])
    end

    def set_payment
      @payment = Payment.find(params[:id])
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
