class Invoice < Expense
  include Expenses::Payable
  include Vehicles::Associatable

  belongs_to :vendor
  has_many :line_items
  has_and_belongs_to_many :fuel_receipts
end
