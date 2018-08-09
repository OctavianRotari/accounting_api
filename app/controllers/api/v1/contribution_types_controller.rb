module Api::V1
  class ContributionTypesController < ApiController
    def index
      contribution_types = current_user.contribution_types
      json_response(contribution_types)
    end

    def create
      begin
        contribution_type = ContributionType.new(other_expense_params)
        contribution_type[:user_id] = current_user.id
        if contribution_type.save
          head :created, location: v1_other_expenses_url(contribution_type)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def update
      contribution_type.update(other_expense_params)
      if(contribution_type.save) 
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def destroy
      contribution_type.destroy
      head :no_content
    end

    private
    def other_expense_params
      params.require(:contribution_type).permit(:desc)
    end

    def contribution_type
      current_user.contribution_types.find_by(id: params[:id])
    end
  end
end
