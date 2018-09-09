class Invoice < Expense
  include Expenses::Payable
  include Vehicles::Associatable

  belongs_to :vendor
  has_many :line_items, dependent: :destroy
  has_and_belongs_to_many :vehicles

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

  def total
    self.line_items.sum(:amount)
  end

  private

  # def save_fuel_receipts
  #   items.map do |fuel_receipt|
  #     line_item = {
  #       vat: 22,
  #       amount: fuel_receipt[:total],
  #       description: 'Scontrino Carburante',
  #       quantity: fuel_receipt[:litres],
  #     }
  #     line_item = self.line_items.create(line_item)
  #     line_item.line_item_to_fuel_receipt = LineItemToFuelReceipt.create(
  #       {line_item_id: line_item.id, fuel_receipt_id: fuel_receipt.id}
  #     )
  #   end
  # end
end
