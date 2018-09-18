class Load < ApplicationRecord
  belongs_to :vehicle
  belongs_to :vendor

  has_one :sold_line_item_to_load, dependent: :destroy
  after_update :update_sold_line_item

  def self.total
    self.sum(:total).to_f
  end

  def sold_line_item
    relation = self.sold_line_item_to_load
    SoldLineItem.find(relation.sold_line_item_id)
  end

  private
  def update_sold_line_item
    if(self.sold_line_item) 
      sold_line_item = self.sold_line_item
      sold_line_item.update({total: self.total, description: "#{self[:from]} - #{self[:to]}: #{self[:desc]}"})
    end
  end
end
