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

  def fuel_receipts_total(start_date = nil, end_date = nil)
    if(start_date and end_date)
      fuel_receipts = self.fuel_receipts.where(
        date_of_issue: (start_date..end_date)
      )
      fuel_receipts.sum(:total).to_f
    else
      self.fuel_receipts.sum(:total).to_f
    end
  end

  def expiring_maintenances
    self.maintenances.where(deadline: (Date.today.beginning_of_month..Date.today.end_of_month))
  end

  def sanctions_total
    self.sanctions.sum(:total).to_f
  end
end
