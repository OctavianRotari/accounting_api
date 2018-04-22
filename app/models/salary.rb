class Salary < ApplicationRecord
  has_and_belongs_to_many :payments
end
