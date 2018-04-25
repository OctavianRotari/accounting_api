class Salary < ApplicationRecord
  belongs_to :employee
  has_and_belongs_to_many :payments

  validates :total, presence: {message: 'required'}
  validates :month, presence: {message: 'required'}
  validates :deadline, presence: {message: 'required'}

  def create_payment(payment)
    total_payments = self.payments.sum(:paid)
    if(payment[:paid] > self.total - total_payments)
        raise "The payment total is bigger than the salary total"
    else
      self.payments.create(payment)
    end
  end

  def paid?
    total_payments = self.payments.sum(:paid)
    self.total === total_payments ? true : false;
  end
end

