class ActiveInvoice < ApplicationRecord
  belongs_to :user
  has_many :sold_line_items, dependent: :destroy

  has_and_belongs_to_many :companies
  has_and_belongs_to_many :payments
  has_and_belongs_to_many :vehicles
end
