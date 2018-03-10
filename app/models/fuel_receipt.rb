class FuelReceipt < ApplicationRecord
  belongs_to :vehicle
  belongs_to :company
end
