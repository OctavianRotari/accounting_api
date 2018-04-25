class Salary < ApplicationRecord
  belongs_to :employee
  has_and_belongs_to_many :payments

  validates :total, presence: {message: 'required'}
  validates :month, presence: {message: 'required'}
  validates :deadline, presence: {message: 'required'}

  def create_payment(payment)
    if(payment[:paid] > self.total)
        raise "The payment total is bigger than the salary total"
    else
      self.payments.create(payment)
    end
  end
end

