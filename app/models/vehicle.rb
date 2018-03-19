class Vehicle < ApplicationRecord
  belongs_to :user

  has_many :invoices_vehicles
  has_many :fuel_receipts, dependent: :destroy

  has_and_belongs_to_many :tickets
  has_and_belongs_to_many :insurances
  has_and_belongs_to_many :invoices
end
