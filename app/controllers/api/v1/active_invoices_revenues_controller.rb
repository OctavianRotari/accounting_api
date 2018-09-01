module Api::V1
  class ActiveInvoicesRevenuesController < ApiController
    before_action :set_revenue, only: [:show, :update, :destroy]

    def index
      revenues = active_invoice.revenues
      json_response(revenues)
    end

    def create
      begin
        revenue = active_invoice.create_revenue(hash_revenue)
        if revenue
          head :created, location: v1_active_invoice_revenues_url(revenue)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    private

    def revenue_params
      params.require(:revenue).permit(
        :total,
        :method_of_revenue,
        :date,
      )
    end

    def active_invoice
      ActiveInvoice.find(params[:active_invoice_id])
    end

    def hash_revenue
      {
        total: revenue_params['total'],
        method_of_payment: revenue_params['method_of_payment'],
        date: revenue_params['date']
      }
    end
  end
end
