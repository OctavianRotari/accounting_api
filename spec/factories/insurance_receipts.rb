FactoryBot.define do
  factory :insurance_receipt do
    total(100)
    method_of_payment('banca')
    date(Date.current.beginning_of_month)
  end
end
