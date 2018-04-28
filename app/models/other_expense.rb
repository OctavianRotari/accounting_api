class OtherExpense < Expense
  belongs_to :user

  validates :desc, presence: {message: 'required'}
  validates :total, presence: {message: 'required'}
  validates :date, presence: {message: 'required'}
end
