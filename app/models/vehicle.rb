class Vehicle < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle_type

  has_many :fuel_receipts, dependent: :destroy
  has_many :maintenances, dependent: :destroy

  has_many :loads

  has_and_belongs_to_many :insurances
  has_and_belongs_to_many :invoices
  has_and_belongs_to_many :sanctions
  has_and_belongs_to_many :sanctions
  has_and_belongs_to_many :financial_contributions

  validates :roadworthiness_check_date, presence: {message: 'required'}
  validates :plate, presence: {message: 'required'}
  validates :vehicle_type_id, presence: {message: 'required'}

  def fuel_receipts_total(start_date = nil, end_date = nil)
    if(start_date and end_date)
      fuel_receipts = self.fuel_receipts.where(
        date: (start_date..end_date)
      )
      fuel_receipts.sum(:total).to_f
    else
      self.fuel_receipts.sum(:total).to_f
    end
  end

  def deadline_tax
    tax = self.financial_contributions.last
    date = Date.parse(tax.date.to_s)
    date.next_year
  end
end
