class Employee < ApplicationRecord
  belongs_to :user
  has_many :salaries, dependent: :destroy

  validates :name, presence: {message: 'required'}
  validates :contract_start_date, presence: {message: 'required'}
  validates :role, presence: {message: 'required'}
end
