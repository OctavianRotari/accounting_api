class Invoice < Expense
  include Expenses::Payable
  include Vehicles::Associatable

  belongs_to :vendor
  has_many :line_items, dependent: :destroy
  has_and_belongs_to_many :vehicles

  validates :line_items, presence: true
  validates :date, presence: {message: 'required'}
  validates :deadline, presence: {message: 'required'}
  validates :description, presence: {message: 'required'}
  validates :serial_number, presence: {message: 'required'}

  def self.total_between_dates(start_date = nil, end_date = nil)
    raise 'Supply start_date & end_date params' if !(start_date and end_date)
    invoices = self.all_between_dates(start_date, end_date)
    total = 0
    invoices.each do |invoice|
      total += invoice.line_items.sum(:amount)
    end
    total.to_f
  end

  def create_line_items(line_items, type = :default)
    if(type === :fuel_receipt)
      line_items = line_items.map do |fuel_receipt_id|
        fuel_receipt = FuelReceipt.find(fuel_receipt_id)
        {
          vat: 22,
          amount: fuel_receipt.litres,
          description: 'Scontrino Carburante',
          quantity: fuel_receipt,
        }
      end
    end
    line_items.each do |line_item|
      self.line_items.create(line_item)
    end
  end

  def total
    self.line_items.sum(:amount)
  end
end
