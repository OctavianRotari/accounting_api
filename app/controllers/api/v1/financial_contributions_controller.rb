module Api::V1
  class FinancialContributionsController < ApiController
    def index
      financial_contributions = current_user.financial_contributions
      json_response(financial_contributions)
    end

    def create
      begin
        financial_contribution = FinancialContribution.new(finacial_contribution_params)
        financial_contribution[:user_id] = current_user.id
        if financial_contribution.save
          if(vehicle_param[:vehicle_id]) 
            vehicle_id = vehicle_param[:vehicle_id]
            financial_contribution.associate_to(vehicle_id)
          end 
          head :created, location: v1_other_expenses_url(financial_contribution)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def update
      financial_contribution.update(finacial_contribution_params)
      if(financial_contribution.save) 
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def destroy
      financial_contribution.destroy
      head :no_content
    end

    private

    def finacial_contribution_params
      params.require(:financial_contribution).permit(
        :desc,
        :total,
        :date,
        :contribution_type_id,
      )
    end

    def vehicle_param
      params.require(:financial_contribution).permit(
        :vehicle_id,
      )
    end

    def financial_contribution
      current_user.financial_contributions.find_by(id: params[:id])
    end
  end
end
