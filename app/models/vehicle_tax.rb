class VehicleTax < Expense
  include Expenses::Payable
  belongs_to :vehicle
end
