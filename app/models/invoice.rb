class Invoice < ApplicationRecord
  belongs_to :vendor
  has_many :line_items
  has_and_belongs_to_many :payments
  has_and_belongs_to_many :fuel_receipts
  has_and_belongs_to_many :vehicles
end
