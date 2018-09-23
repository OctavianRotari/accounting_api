class VehicleType < ApplicationRecord
  has_many :vehicles
  belongs_to :user, optional: true
end
