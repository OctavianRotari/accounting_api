class Insurance < Expense
  include Vehicles::Associatable

  belongs_to :vendor
  has_many :insurance_receipts, dependent: :destroy
end
