class Insurance < ApplicationRecord
  belongs_to :vendor
  has_and_belongs_to_many :vehicles
  has_many :insurance_receipts, dependent: :destroy
end
