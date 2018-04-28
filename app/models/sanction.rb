class Sanction < Expense
  include Expenses::Payable
  include Vehicles::Associatable

  belongs_to :user

  validates :total, presence: {message: 'required'}
  validates :date, presence: {message: 'required'}
  validates :deadline, presence: {message: 'required'}

end
