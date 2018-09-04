class Insurance < Expense
  include Expenses::Payable
  include Vehicles::Associatable

  belongs_to :vendor
  has_many :insurance_receipts, dependent: :destroy
  alias_attribute :payments, :insurance_receipts

  validates :date, presence: {message: 'required'}
  validates :deadline, presence: {message: 'required'}
  validates :description, presence: {message: 'required'}
  validates :total, presence: {message: 'required'}
  validates :serial_of_contract, presence: {message: 'required'}
  validates :payment_recurrence, presence: {message: 'required'}

  def self.vehicle(insurance)
    begin
      vehicle_id = insurance[:vehicle_id]
      'Pass vehicle id' if !vehicle_id
      if(Vehicle.find(vehicle_id).has_active_insurance) 
        'A vehicle cannot have more than one active insurance.'
      else
        insurance.delete(:vehicle_id)
        insurance = Insurance.new(insurance)
        if insurance.save
          vehicle = Vehicle.find(vehicle_id)
          vehicle.insurances << insurance
        else
          insurance
        end
      end
    rescue => e
      e
    end
  end

  private
  def create_payment(receipt)
    payment = {
      total: receipt[:total],
      method_of_payment: receipt[:method_of_payment],
      date: receipt[:date],
    }
    Payment.new(payment)
  end
end
