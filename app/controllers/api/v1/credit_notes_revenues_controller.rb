module Api::V1
  class CreditNotesRevenuesController < ApiController
    before_action :set_revenue, only: [:show, :update, :destroy]

    def index
      revenues = credit_note.revenues
      json_response(revenues)
    end

    def create
      begin
        revenue = credit_note.create_revenue(hash_revenue)
        if revenue
          head :created, location: v1_credit_note_revenues_url(revenue)
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

    def credit_note
      CreditNote.find(params[:credit_note_id])
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
