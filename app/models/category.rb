class Category < ApplicationRecord
  belongs_to :user
  has_many :companies

  validates :name, presence: {message: 'required'}
end
