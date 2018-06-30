module Api::V1
  class OtherExpensesController < ApiController
    # before_action :authenticate_user!

    def index
      @other_expenses = OtherExpense.all
      json_response(@other_expenses)
    end
  end
end
