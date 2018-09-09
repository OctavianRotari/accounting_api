class LineItem < ApplicationRecord
  belongs_to :invoice
  has_one :line_item_to_fuel_receipt

  has_one :fuel_receipt, through: :line_item_to_fuel_receipt
  before_destroy :check_line_item

  def fuel_receipt
    relation = self.line_item_to_fuel_receipt
    FuelReceipt.find(relation.fuel_receipt_id)
  end

  private

  def check_line_item
    is_last
    if(self.line_item_to_fuel_receipt)
      self.line_item_to_fuel_receipt.destroy
    end
  end

  def is_last
    invoice_line_items = self.invoice.line_items
    if(invoice_line_items.length === 1 and invoice_line_items === [self]) 
      errors.add(:last, 'line_item for invoice cannot be deleted')
    end
  end
end
