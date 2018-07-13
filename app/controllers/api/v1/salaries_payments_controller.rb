module Api::V1
  class SalariesPaymentsController < ApiController
    def index
      payments = salary.payments
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
        payment = salary.create_payment(hash_payment)
        if payment
          head :created, location: v1_employee_salary_payments_url(payment)
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

    def employee
      current_user.employees.find_by(id: params[:employee_id])
    end

    def salary
      employee.salaries.find_by(id: params[:salary_id])
    end

    def payment
      salary.payments.find_by(id: params[:id])
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
