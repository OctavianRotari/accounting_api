class ApplicationController < ActionController::API
  include Response
  include DeviseTokenAuth::Concerns::SetUserByToken
end
