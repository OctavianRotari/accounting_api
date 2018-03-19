class Company < ApplicationRecord
  belongs_to :category

  has_and_belongs_to_many :invoices
  has_and_belongs_to_many :insurances

  validates :name, presence: {message: 'required'}
  validates :adress, presence: {message: 'required'}
  validates :number, presence: {message: 'required'}
end
