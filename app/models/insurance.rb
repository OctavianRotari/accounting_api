class Insurance < Expense
  include Expenses::Payable
  include Vehicles::Associatable

  belongs_to :vendor
  has_many :insurance_receipts, dependent: :destroy
  alias_attribute :payments, :insurance_receipts

  validates :date, presence: {message: 'required'}
  validates :deadline, presence: {message: 'required'}
  validates :description, presence: {message: 'required'}
  validates :total, presence: {message: 'required'}
  validates :serial_of_contract, presence: {message: 'required'}
  validates :payment_recurrence, presence: {message: 'required'}

  def add_receipt(receipt)
    begin
      payment = {
        total: receipt[:total],
        method_of_payment: receipt[:method_of_payment],
        date: receipt[:date],
      }
      payment = Payment.new(payment)
      if payment.save
        receipt = InsuranceReceipt.new(receipt)
        self.insurance_receipts << receipt
      else
        payment
      end
    rescue => e
      e
    end
  end
end
