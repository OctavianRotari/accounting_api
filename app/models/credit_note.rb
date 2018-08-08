class CreditNote < Expense
  include Profits::Cashable

  belongs_to :vendor
  has_and_belongs_to_many :revenues

  validates :date, presence: {message: 'required'}
  validates :total, presence: {message: 'required'}
end
