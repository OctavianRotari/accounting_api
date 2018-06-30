module Api
  module V1
    class OtherExpensesController < ApplicationController
      # before_action :authenticate_user!

      def index
        other_expenses = OtherExpense.all
        [] if other_expenses.length === 0
        other_expenses
      end
    end
  end
end
