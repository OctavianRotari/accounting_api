class Invoice < ApplicationRecord
  belongs_to :vehicle
  has_many :line_items, dependent: :destroy
  has_many :vehicle_line_items, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_and_belongs_to_many :companies
end
