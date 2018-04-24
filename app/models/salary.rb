class Salary < ApplicationRecord
  belongs_to :employee
  has_and_belongs_to_many :payments

  validates :total, presence: {message: 'required'}
  validates :month, presence: {message: 'required'}
  validates :deadline, presence: {message: 'required'}
end
