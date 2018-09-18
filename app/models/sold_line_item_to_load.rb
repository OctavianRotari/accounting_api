class SoldLineItemToLoad < ApplicationRecord
  has_one :sold_line_item
  has_one :load

  validates :sold_line_item_id, presence: {message: 'required'}
  validates :load_id, presence: {message: 'required'}
end
