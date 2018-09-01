FactoryBot.define do
  factory :active_invoice do
    before(:create) do |active_invoice|
      active_invoice.sold_line_items << FactoryBot.create(:sold_line_item, active_invoice: active_invoice)
    end
    vendor
    date(DateTime.new())
    deadline(DateTime.new() + 1.month)
    serial_number('2341gh')
    description('I bought something')
  end
end
