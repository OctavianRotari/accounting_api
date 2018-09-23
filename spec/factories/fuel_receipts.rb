FactoryBot.define do
  factory :fuel_receipt do
    vehicle
    vendor

    total(230)
    litres(200.43)
    date(Date.today)
  end
end
