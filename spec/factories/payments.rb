FactoryBot.define do
  factory :payment do
    total(100)
    method_of_payment('banca')
    date(Date.current.beginning_of_month + 3)
  end
end
