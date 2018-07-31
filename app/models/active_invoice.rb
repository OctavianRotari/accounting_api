class ActiveInvoice < Expense
  include Profits::Cashable
  include Vehicles::Associatable

  belongs_to :vendor
  has_many :sold_line_items, dependent: :destroy
  has_and_belongs_to_many :vehicles

  validates :date_of_issue, presence: {message: 'required'}
  validates :deadline, presence: {message: 'required'}
  validates :description, presence: {message: 'required'}
  validates :serial_number, presence: {message: 'required'}

  def create_sold_line_items(sold_line_items)
    sold_line_items.each do |sold_line_item|
      self.sold_line_items.create(sold_line_item)
    end
  end

  def total
    self.sold_line_items.sum(:amount)
  end
end
