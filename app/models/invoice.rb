class Invoice < ApplicationRecord
  belongs_to :vehicle
  belongs_to :company

  has_many :payments, dependent: :destroy
  has_many :taxable_vat_fields, dependent: :destroy
  has_many :vehicle_fields, dependent: :destroy
end
