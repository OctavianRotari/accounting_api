class VehicleTax < ApplicationRecord
  belongs_to :vehicle
  has_and_belongs_to_many :payments
end
