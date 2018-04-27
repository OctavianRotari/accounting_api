class Sanction < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :payments
  has_and_belongs_to_many :vehicles

  validates :total, presence: {message: 'required'}
  validates :date, presence: {message: 'required'}
  validates :deadline, presence: {message: 'required'}

  def create_payment(payment)
    total_payments = self.payments.sum(:paid)
    if(payment[:paid] > self.total - total_payments)
        raise "The payment total is bigger than the sanction total"
    else
      self.payments.create(payment)
    end
  end

  def create_fine_association(vehicle_id)
    vehicle = Vehicle.find(vehicle_id)
    self.vehicles << vehicle
  end

  def paid?
    total_payments = self.payments.sum(:paid)
    self.total === total_payments ? true : false;
  end

  def self.total
    self.sum(:total).to_f
  end
end
