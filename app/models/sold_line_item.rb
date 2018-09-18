class SoldLineItem < ApplicationRecord
  belongs_to :active_invoice
  has_one :sold_line_item_to_load, dependent: :destroy

  before_destroy :check_sold_line_item
  after_update :update_load

  def load
    if(self.sold_line_item_to_load)
      relation = self.sold_line_item_to_load
      Load.find(relation.load_id)
    end
  end

  def self.create_load_line_item(load, active_invoice_id)
    sold_line_item = {
      vat: 22,
      total: load[:total],
      description: "#{load[:from]} - #{load[:to]}: #{load[:desc]}",
      quantity: 1,
      active_invoice_id: active_invoice_id,
    }
    sold_line_item = SoldLineItem.create(sold_line_item)
    SoldLineItemToLoad.create(
      {sold_line_item_id: sold_line_item[:id], load_id: load[:id]}
    )
    true
  end

  private

  def check_sold_line_item
    is_last
    if(self.sold_line_item_to_load)
      self.sold_line_item_to_load.destroy
    end
  end

  def is_last
    active_invoice_line_items = self.active_invoice.sold_line_items
    if(
        active_invoice_line_items.length === 1 and
        active_invoice_line_items === [self]
    )
      errors.add(:last, 'sold_line_item for active_invoice cannot be deleted')
    end
  end

  def update_load
    if(self.load and self.load[:total] != self.total) 
      load = self.load
      load.update({total: self.total})
    end
  end
end
