module Api::V1
  class InvoicesPaymentsController < ApiController
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
          head :created, location: v1_sanction_payments_url(payment)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def destroy
      payment.destroy
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
      vendor.invoices.find_by(id: params[:invoice_id])
    end

    def vendor
      current_user.vendors.find_by(id: params[:vendor_id])
    end

    def payment
      invoice.payments.find_by(id: params[:id])
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
