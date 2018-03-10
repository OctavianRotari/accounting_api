class Insurance < ApplicationRecord
  belongs_to :vehicle
  belongs_to :company
end
