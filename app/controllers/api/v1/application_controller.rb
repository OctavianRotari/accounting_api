module Api
  module V1
    class ApplicationController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
        before_action :authenticate_api_v1_user!
    end
  end
end
