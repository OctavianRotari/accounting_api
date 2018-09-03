FactoryBot.define do
  factory :payment do
    trait :valid do
      total(100)
      method_of_payment('banca')
      date(Date.current.beginning_of_month + 3)
    end

    trait :invalid do
      total(nil)
      method_of_payment(nil)
      date(nil)
    end
  end
end
