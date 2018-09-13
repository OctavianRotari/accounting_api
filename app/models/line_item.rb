class LineItem < ApplicationRecord
  belongs_to :invoice
  has_one :line_item_to_fuel_receipt, dependent: :destroy 

  has_one :fuel_receipt, through: :line_item_to_fuel_receipt
  before_destroy :check_line_item
  after_update :update_fuel_receipt

  def fuel_receipt
    if(self.line_item_to_fuel_receipt)
      relation = self.line_item_to_fuel_receipt
      FuelReceipt.find(relation.fuel_receipt_id)
    end
  end

  def self.create_fuel_line_item(fuel_receipt, invoice_id)
    line_item = {
      vat: 22,
      total: fuel_receipt[:total],
      description: 'Scontrino Carburante',
      quantity: fuel_receipt[:litres],
      invoice_id: invoice_id,
    }
    line_item = LineItem.create(line_item)
    LineItemToFuelReceipt.create(
      {line_item_id: line_item[:id], fuel_receipt_id: fuel_receipt[:id]}
    )
    true
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

  def update_fuel_receipt
    if(self.fuel_receipt and self.fuel_receipt[:total] != self.total) 
      fuel_receipt = self.fuel_receipt
      fuel_receipt.update({total: self.total})
    end
  end
end
