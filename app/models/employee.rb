class Employee < ApplicationRecord
  belongs_to :user
  has_many :salaries, dependent: :destroy
end
