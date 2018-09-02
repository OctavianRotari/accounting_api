class Insurance < Expense
  include Expenses::Payable
  include Vehicles::Associatable

  belongs_to :vendor
  has_many :insurance_receipts, dependent: :destroy
  alias_attribute :insurance_receipts, :payments
end
