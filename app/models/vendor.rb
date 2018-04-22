class Vendor < ApplicationRecord
  belongs_to :user

  has_many :invoices
  has_many :insurances

  validates :name, presence: {message: 'required'}
  validates :adress, presence: {message: 'required'}
  validates :number, presence: {message: 'required'}
end
