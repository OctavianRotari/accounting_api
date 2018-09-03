class InsuranceReceipt < Expense
  include Expenses::Payable
  belongs_to :insurance

  validates :date, presence: {message: 'required'}
  validates :total, presence: {message: 'required'}
  validates :method_of_payment, presence: {message: 'required'}
end
