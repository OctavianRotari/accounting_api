class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :categories, dependent: :destroy
  has_many :active_invoices, dependent: :destroy
  has_many :insurances, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :vehicles, dependent: :destroy

  has_many :companies, through: :categories
  has_many :fuel_receipts, through: :vehicles
  has_many :insurance_receipts, through: :insurances
  has_many :line_items, through: :invoices
  has_many :payments, through: :invoices
  has_many :sold_line_items, through: :active_invoices
end
