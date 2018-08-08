class Invoice < Expense
  include Expenses::Payable
  include Vehicles::Associatable

  belongs_to :vendor
  has_many :line_items
  has_and_belongs_to_many :vehicles

  validates :date, presence: {message: 'required'}
  validates :deadline, presence: {message: 'required'}
  validates :description, presence: {message: 'required'}
  validates :serial_number, presence: {message: 'required'}

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
