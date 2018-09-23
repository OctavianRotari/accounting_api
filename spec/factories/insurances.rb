FactoryBot.define do
  factory :insurance do
    vendor

    trait :with_vehicle do
      vehicle
    end

    trait :valid do
      date(Date.today())
      deadline(Date.today.next_year())
      description("RCA + something else")
      total(3200.00)
      serial_of_contract("09243vs")
      payment_recurrence(2)
    end

    trait :expired do
      date(Date.today.last_year())
      total(2200.00)
      deadline(Date.yesterday)
    end

    trait :put do
      description("RCA")
      total(3400.00)
    end

    trait :invalid do
      date(nil)
      deadline(nil)
      description(nil)
      total(nil)
      serial_of_contract(nil)
      payment_recurrence(nil)
    end
  end
end
