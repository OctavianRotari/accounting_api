class InsuranceReceipt < Expense
  include Expenses::Payable
  belongs_to :insurance
end
