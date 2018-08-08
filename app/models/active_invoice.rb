class ActiveInvoice < Expense
  include Profits::Cashable
  include Vehicles::Associatable

  belongs_to :vendor
  has_many :sold_line_items, dependent: :destroy
  has_and_belongs_to_many :vehicles

  validates :date, presence: {message: 'required'}
  validates :deadline, presence: {message: 'required'}
  validates :description, presence: {message: 'required'}
  validates :serial_number, presence: {message: 'required'}

  def self.total_between_dates(start_date = nil, end_date = nil)
    raise 'Supply start_date & end_date params' if !(start_date and end_date)
    active_invoices = self.all_between_dates(start_date, end_date)
    total = 0
    active_invoices.each do |active_invoice|
      total += active_invoice.sold_line_items.sum(:amount)
    end
    total.to_f
  end

  def create_sold_line_items(sold_line_items)
    sold_line_items.each do |sold_line_item|
      self.sold_line_items.create(sold_line_item)
    end
  end

  def total
    self.sold_line_items.sum(:amount)
  end
end
