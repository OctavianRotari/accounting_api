FactoryBot.define do
  factory :sold_line_item do
    active_invoice
    vat 1
    amount "1000"
    description "Container"
  end
end
