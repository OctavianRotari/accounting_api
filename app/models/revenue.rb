class Revenue < ApplicationRecord
  has_and_belongs_to_many :active_invoices
  has_and_belongs_to_many :credit_notes
end
