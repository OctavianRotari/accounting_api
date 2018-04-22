class Sanction < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :payments
  has_and_belongs_to_many :vehicles
end
