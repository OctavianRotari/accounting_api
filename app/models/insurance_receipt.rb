class InsuranceReceipt < Expense
  include Expenses::Payable

  belongs_to :insurance
  after_save :create_payment

  validate :check_total
  validates :date, presence: {message: 'required'}
  validates :total, presence: {message: 'required'}
  validates :method_of_payment, presence: {message: 'required'}

  private
  def check_total
    insurance_receipts_total = InsuranceReceipt.where(insurance_id: self.insurance_id).sum(:total).to_f
    insurance_total = Insurance.find(self.insurance_id).total.to_f
    if (self.total.to_f + insurance_receipts_total) > insurance_total
      errors.add(:total, 'Total too big')
    end
  end

  def create_payment
    payment = {
      total: self[:total],
      method_of_payment: self[:method_of_payment],
      date: self[:date],
    }
    payment = Payment.create(payment)
    self.payments << payment
  end
end
