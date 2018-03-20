class ActiveInvoice < ApplicationRecord
  belongs_to :user
  has_many :sold_line_items, dependent: :destroy

  has_one :company, through: :companies_invoices
  has_and_belongs_to_many :payments
  has_and_belongs_to_many :vehicles
end
