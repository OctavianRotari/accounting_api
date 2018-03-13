class Vehicle < ApplicationRecord
  belongs_to :user

  has_many :vehicle_line_item

  has_many :vehicle_field, dependent: :destroy
  has_many :fuel_receipts, dependent: :destroy
  has_many :insurances, dependent: :destroy
  has_many :tickets, dependent: :destroy
end
