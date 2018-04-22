class Salary < ApplicationRecord
  belongs_to :employee
  has_and_belongs_to_many :payments
end
