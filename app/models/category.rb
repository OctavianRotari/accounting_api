class Category < ApplicationRecord
  belongs_to :user

  validates :name, presence: {message: 'required'}
end
