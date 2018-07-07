module Api::V1
  class SalariesController < ApiController
    def index
      salaries = current_user.salaries
      json_response(salaries)
    end

    def update
      salary.update(salary_params)
      if(salary.save)
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def create
      begin
        salary = employee.salaries.new(salary_params)
        if salary.save
          head :created, location: v1_employee_salaries_url(salary)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def destroy
      salary.destroy
      head :no_content
    end

    private

    def salary_params
      params.require(:salary).permit(
        :total,
        :month,
        :deadline,
      )
    end

    def employee
      current_user.employees.find_by(id: params[:employee_id])
    end

    def salary
      current_user.salaries.find_by(id: params[:id])
    end
  end
end
