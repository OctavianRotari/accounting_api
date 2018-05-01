class SoldLineItem < ApplicationRecord
  belongs_to :active_invoice

  has_and_belongs_to_many :loads
end
