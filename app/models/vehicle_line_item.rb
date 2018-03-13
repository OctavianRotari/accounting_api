class VehicleLineItem < ApplicationRecord
  belongs_to :vehicle
  belongs_to :invoice
end
