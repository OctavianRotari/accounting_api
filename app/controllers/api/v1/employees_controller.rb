module Api::V1
  class EmployeesController < ApiController
    def index
      employees = current_user.employees
      json_response(employees)
    end

    def update
      employee.update(employee_params)
      if(employee.save)
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def create
      begin
        employee = current_user.employees.new(employee_params)
        if employee.save
          head :created, location: v1_employees_url(employee)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def destroy
      employee.destroy
      head :no_content
    end

    private

    def employee_params
      params.require(:employee).permit(
        :name,
        :surname,
        :contract_start_date,
        :role,
        :contract_end_date
      )
    end

    def employee
      current_user.employees.find_by(id: params[:id])
    end
  end
end
