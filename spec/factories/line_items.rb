FactoryBot.define do
  factory :line_item do
    invoice
    vat 1
    amount "9.99"
    description "Bulloni"
  end
end
