module Api::V1
  class VendorsController < ApiController
    def index
      @vendors = current_user.vendors
      json_response(@vendors)
    end
  end
end
