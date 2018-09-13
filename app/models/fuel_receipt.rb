class FuelReceipt < Expense
  belongs_to :vehicle
  belongs_to :vendor

  has_one :line_item_to_fuel_receipt, dependent: :destroy

  def line_item
    relation = self.line_item_to_fuel_receipt
    LineItem.find(relation.line_item_id)
  end
end
