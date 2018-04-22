class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :vendors, dependent: :destroy
  has_many :other_expenses, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :financial_contributions, dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :sanctions, dependent: :destroy
end
