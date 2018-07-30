class InsuranceReceipt < ApplicationRecord
  belongs_to :insurance
  belongs_to :payments, class_name: 'Payment', foreign_key: 'payment_id'
end
