class LineItem < ApplicationRecord
  belongs_to :invoice

  has_and_belongs_to_many :fuel_receipts
end
