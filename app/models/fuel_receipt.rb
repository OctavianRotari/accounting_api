class FuelReceipt < Expense
  belongs_to :vehicle
  belongs_to :vendor

  has_one :line_item_to_fuel_receipt, dependent: :destroy
  after_update :update_line_item

  def line_item
    if(self.line_item_to_fuel_receipt)
      relation = self.line_item_to_fuel_receipt
      LineItem.find(relation.line_item_id)
    end
  end

  private

  def update_line_item
    if(self.line_item) 
      line_item = self.line_item
      line_item.update({total: self.total, quantity: self.litres})
    end
  end
end
