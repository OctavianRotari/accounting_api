class VehicleField < ApplicationRecord
  belongs_to :invoice
  belongs_to :vehicle
end
