class Invoice < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :payments, dependent: :destroy

  has_and_belongs_to_many :companies
  has_and_belongs_to_many :vehicles
end
