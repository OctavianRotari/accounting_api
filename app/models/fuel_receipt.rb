class FuelReceipt < Expense
  belongs_to :vehicle
  belongs_to :vendor

  has_one :line_item_to_fuel_receipt, dependent: :destroy
  after_update :update_line_item

  def line_item
    relation = self.line_item_to_fuel_receipt
    LineItem.find(relation.line_item_id)
  end

  private

  def update_line_item
    if(self.line_item) 
      line_item = self.line_item
      line_item.update({total: self.total, quantity: self.litres})
    end
  end
end
