module Vehicles
  module Associatable
    extend ActiveSupport::Concern
    included do
      has_and_belongs_to_many :vehicles
    end

    def associate_to(vehicle_id)
      vehicle = Vehicle.find(vehicle_id)
      self.vehicles << vehicle
    end
  end
end
