class Vehicle < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle_type

  has_many :fuel_receipts, dependent: :destroy
  has_many :maintenances, dependent: :destroy

  has_many :vehicle_taxes
  has_many :loads

  has_and_belongs_to_many :insurances
  has_and_belongs_to_many :invoices
  has_and_belongs_to_many :sanctions

  validates :roadworthiness_check_date, presence: {message: 'required'}
  validates :plate, presence: {message: 'required'}


end
