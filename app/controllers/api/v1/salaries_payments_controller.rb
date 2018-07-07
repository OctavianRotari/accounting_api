module Api::V1
  class SalariesPaymentsController < ApiController
    def index
      salaries = current_user.salaries
      json_response(salaries)
    end

    def update
      salary.update(payment_params)
      if(salary.save)
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
          puts('here')
          head :unprocessable_entity
        end
      rescue => e
        puts('erro' + e.to_s)
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def destroy
      salary.destroy
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
      current_user.salaries.find_by(id: params[:salary_id])
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
