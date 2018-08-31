class FuelReceipt < Expense
  belongs_to :vehicle
  belongs_to :vendor
  has_and_belongs_to_many :line_item
end
