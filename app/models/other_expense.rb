class OtherExpense < Expense
  belongs_to :user

  validates :desc, presence: {message: 'required'}
  validates :total, presence: {message: 'required'}
  validates :date, presence: {message: 'required'}

  def self.total_paid
    self.sum(:total).to_f
  end
end
