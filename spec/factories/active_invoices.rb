FactoryBot.define do
  factory :active_invoice do
    date_of_issue(DateTime.new())
    collected(false)
    deadline(DateTime.new() + 1.month)
    serial_number('2341gh')
    description('I bought something')
  end
end
