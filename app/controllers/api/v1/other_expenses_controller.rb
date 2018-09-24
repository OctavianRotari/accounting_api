module Api::V1
  class OtherExpensesController < ApiController
    def index
      other_expenses = current_user.other_expenses
      json_response(other_expenses)
    end

    def create
      begin
        other_expense = OtherExpense.new(other_expense_params)
        other_expense[:user_id] = current_user.id
        if other_expense.save
          head :created, location: v1_other_expenses_url(other_expense)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def update
      other_expense.update(other_expense_params)
      if(other_expense.save) 
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def destroy
      other_expense.destroy
      head :no_content
    end

    private
    def other_expense_params
      params.permit(
        :desc,
        :total,
        :date
      )
    end

    def other_expense
      current_user.other_expenses.find_by(id: params[:id])
    end
  end
end
