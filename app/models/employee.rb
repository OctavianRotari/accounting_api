class Employee < ApplicationRecord
  has_many :salaries, dependent: :destroy
end
