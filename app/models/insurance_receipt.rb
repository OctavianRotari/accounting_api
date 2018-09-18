class InsuranceReceipt < Expense
  include Expenses::Payable

  belongs_to :insurance
  after_save :create_payment
  after_update :update_payment

  has_one :insurance_receipt_to_payment, dependent: :destroy

  validate :check_total
  validates :date, presence: {message: 'required'}
  validates :total, presence: {message: 'required'}
  validates :method_of_payment, presence: {message: 'required'}

  def payment
    if(self.insurance_receipt_to_payment)
      relation = self.insurance_receipt_to_payment
      Payment.find(relation.payment_id)
    end
  end

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
    InsuranceReceiptToPayment.create(
      {payment_id: payment.id, insurance_receipt_id: self.id}
    )
  end

  def update_payment
    payment = {
      total: self[:total],
      method_of_payment: self[:method_of_payment],
      date: self[:date],
    }
    Payment.update(payment)
  end
end
