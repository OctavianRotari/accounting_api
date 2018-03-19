class Payment < ApplicationRecord
  has_and_belongs_to_many :invoice
  has_and_belongs_to_many :active_invoice
end
