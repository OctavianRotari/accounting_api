class InsuranceReceiptToPayment < ApplicationRecord
  has_one :payment
  has_one :insurance_receipt

  validates :insurance_receipt_id, presence: {message: 'required'}
  validates :payment_id, presence: {message: 'required'}
end
