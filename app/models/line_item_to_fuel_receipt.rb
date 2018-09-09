class LineItemToFuelReceipt < ApplicationRecord
  has_one :line_item
  has_one :fuel_receipt

  validates :line_item_id, presence: {message: 'required'}
  validates :fuel_receipt_id, presence: {message: 'required'}
end
