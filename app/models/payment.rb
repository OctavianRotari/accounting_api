class Payment < ApplicationRecord
  has_and_belongs_to_many :invoices
  has_and_belongs_to_many :sanctions
  has_and_belongs_to_many :salaries
end
