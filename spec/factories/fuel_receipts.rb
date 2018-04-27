FactoryBot.define do
  factory :fuel_receipt do
    vehicle
    vendor
    total(230)
    date_of_issue(Date.today)
  end
end
