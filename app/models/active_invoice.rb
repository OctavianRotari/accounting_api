class ActiveInvoice < ApplicationRecord
  belongs_to :vendor
  has_many :sold_line_items, dependent: :destroy

  has_and_belongs_to_many :loads
  has_and_belongs_to_many :vehicles
  has_and_belongs_to_many :revenues
end
