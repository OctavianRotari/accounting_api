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

    trait :loads do
      after(:create) do |active_invoice|
        load = FactoryBot.create(:load, vendor_id: active_invoice.vendor_id)
        sold_line_item = FactoryBot.create(:sold_line_item, active_invoice_id: active_invoice.id, total: load[:total])
        SoldLineItemToLoad.create(
          {
            sold_line_item_id: sold_line_item.id, 
            load_id: load.id
          }
        )
      end
    end
  end
end
