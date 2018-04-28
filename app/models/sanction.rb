class Sanction < Expense
  include Expenses::Payable
  belongs_to :user
  has_and_belongs_to_many :vehicles

  validates :total, presence: {message: 'required'}
  validates :date, presence: {message: 'required'}
  validates :deadline, presence: {message: 'required'}

  def create_fine_association(vehicle_id)
    vehicle = Vehicle.find(vehicle_id)
    self.vehicles << vehicle
  end
end
