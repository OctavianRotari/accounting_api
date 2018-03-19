class Insurance < ApplicationRecord
  belongs_to :user
  has_many :insurance_receipts, dependent: :destroy

  has_and_belongs_to_many :companies
  has_and_belongs_to_many :vehicles
end
