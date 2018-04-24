class OtherExpense < ApplicationRecord
  belongs_to :user

  validates :desc, presence: {message: 'required'}
  validates :total, presence: {message: 'required'}
  validates :date, presence: {message: 'required'}

  def self.total
    self.sum(:total).to_f
  end
end
