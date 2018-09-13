FactoryBot.define do
  factory :active_invoice do
    vendor
    date(DateTime.new())
    deadline(DateTime.new() + 1.month)
    serial_number('2341gh')
    description('I bought something')

    trait :sold_items do
      after(:create) do |active_invoice|
        FactoryBot.create(:sold_line_item, active_invoice_id: active_invoice.id)
        FactoryBot.create(:sold_line_item, active_invoice_id: active_invoice.id)
      end
    end
  end
end
