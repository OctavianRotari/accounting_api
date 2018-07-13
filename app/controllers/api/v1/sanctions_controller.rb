module Api::V1
  class SanctionsController < ApiController
    def index
      sanctions = current_user.sanctions
      json_response(sanctions)
    end

    def update
      sanction.update(sanction_params)
      if(sanction.save)
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def create
      begin
        sanction = current_user.sanctions.new(sanction_params)
        if sanction.save
          head :created, location: v1_sanctions_url(sanction)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def destroy
      sanction.destroy
      head :no_content
    end

    private

    def sanction_params
      params.require(:sanction).permit(
        :total,
        :date,
        :deadline,
      )
    end

    def sanction
      current_user.sanctions.find_by(id: params[:id])
    end
  end
end
