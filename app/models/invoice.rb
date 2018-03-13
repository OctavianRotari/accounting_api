class Invoice < ApplicationRecord
  belongs_to :vehicle

  has_many :payments, dependent: :destroy
  has_many :taxable_vat_fields, dependent: :destroy
  has_many :vehicle_fields, dependent: :destroy

  has_and_belongs_to_many :companies
end
