class Expense < ApplicationRecord
  self.abstract_class = true

  def self.total
    self.sum(:total).to_f
  end

  def self.total_between_dates(start_date = nil, end_date = nil)
    raise 'Supply start_date & end_date params' if !(start_date and end_date)
    expenses = self.where(
      date: (start_date..end_date)
    )
    expenses.sum(:total).to_f
  end

  def self.all_between_dates(start_date = nil, end_date = nil)
    raise 'Supply start_date & end_date params' if !(start_date and end_date)
    self.where(
      date: (start_date..end_date)
    )
  end
end
