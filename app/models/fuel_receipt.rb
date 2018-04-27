class FuelReceipt < ApplicationRecord
  belongs_to :vehicle
  belongs_to :vendor

  has_and_belongs_to_many :invoices

  def self.total
    self.sum(:total).to_f
  end
end
