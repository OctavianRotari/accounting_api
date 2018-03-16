class ActiveInvoice < ApplicationRecord
  has_many :sold_line_items, dependent: :destroy
end
