FactoryBot.define do
  factory :active_invoice do
    vendor
    date(DateTime.new())
    deadline(DateTime.new() + 1.month)
    serial_number('2341gh')
    description('I bought something')
  end
end
