require 'rails_helper'

FactoryBot.define do
  factory :invoice do
    vendor
    date(Date.today())
    deadline(Date.today.next_month())
    description("Pezzi di ricambio")
    serial_number("09243vs")

    trait :items do
      items_type('line_item')
      items([
        {'vat': 1, 'amount': '9.99', 'description': 'bulloni'},
        {'vat': 1, 'amount': '9.99', 'description': 'bulloni'}
      ])
    end

    trait :fuel_receipts do
      items_type('fuel_receipt')
      items([{'total': 230, 'litres': 200.43, 'date': Date.today}])
    end
  end
end
