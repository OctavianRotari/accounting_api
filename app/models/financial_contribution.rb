class FinancialContribution < Expense
  belongs_to :user
  belongs_to :contribution_type

  validates :desc, presence: {message: 'required'}
  validates :total, presence: {message: 'required'}
  validates :date, presence: {message: 'required'}

  def self.find_where(contribution_type_id)
    self.where(contribution_type_id: contribution_type_id)
  end

  def self.calc_total_where(contribution_type_id)
    self.where(contribution_type_id: contribution_type_id).sum(:total).to_f
  end
end
