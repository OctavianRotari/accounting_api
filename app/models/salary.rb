class Salary < Expense
  include Expenses::Payable
  belongs_to :employee

  validates :total, presence: {message: 'required'}
  validates :month, presence: {message: 'required'}
  validates :deadline, presence: {message: 'required'}
end

