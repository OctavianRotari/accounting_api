module Api::V1
  class OtherExpensesController < ApiController

    def index
      @other_expenses = current_user.other_expenses
      json_response(@other_expenses)
    end
  end
end
