class Insurance < Expense
  include Expenses::Payable
  include Vehicles::Associatable

  belongs_to :vendor
  has_many :insurance_receipts, dependent: :destroy
  alias_attribute :insurance_receipts, :payments

  validates :date, presence: {message: 'required'}
  validates :deadline, presence: {message: 'required'}
  validates :description, presence: {message: 'required'}
  validates :total, presence: {message: 'required'}
  validates :serial_of_contract, presence: {message: 'required'}
  validates :payment_recurrence, presence: {message: 'required'}
end
