class Vendor < ApplicationRecord
  belongs_to :user

  has_many :invoices, dependent: :destroy
  has_many :fuel_receipts, dependent: :destroy
  has_many :insurances, dependent: :destroy
  has_many :active_invoices, dependent: :destroy
  has_many :credit_notes, dependent: :destroy

  validates :name, presence: {message: 'required'}
  validates :address, presence: {message: 'required'}
  validates :number, presence: {message: 'required'}
end
