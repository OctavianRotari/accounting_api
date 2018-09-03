FactoryBot.define do
  factory :insurance_receipt do
    trait :valid do
      total(100)
      method_of_payment('banca')
      date(Date.current.beginning_of_month)
    end

    trait :invalid do
      total(nil)
      method_of_payment(nil)
      date(nil)
    end
  end
end
