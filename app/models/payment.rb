class Payment < ApplicationRecord
  has_and_belongs_to_many :invoices
  has_and_belongs_to_many :sanctions
  has_and_belongs_to_many :salaries

  validates :date, presence: {message: 'required'}
  validates :total, presence: {message: 'required'}
  validates :method_of_payment, presence: {message: 'required'}
end
