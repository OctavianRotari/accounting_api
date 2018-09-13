class FuelReceipt < Expense
  belongs_to :vehicle
  belongs_to :vendor

  has_one :line_item_to_fuel_receipt

  def line_item
    relation = self.line_item_to_fuel_receipt
    byebug
    LineItem.find(relation.line_item_id)
  end
end
