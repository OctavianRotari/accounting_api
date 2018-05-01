class Load < ApplicationRecord
  belongs_to :vehicle
  belongs_to :vendor

  has_and_belongs_to_many :sold_line_items
end
