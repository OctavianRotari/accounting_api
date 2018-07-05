class Maintenance < ApplicationRecord
  belongs_to :vehicle

  validates :date, presence: {message: 'required'}
  validates :desc, presence: {message: 'required'}
  validates :vehicle_id, presence: {message: 'required'}
end
