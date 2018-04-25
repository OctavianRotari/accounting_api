FactoryBot.define do
  factory :payment do
    paid(100)
    method_of_payment('banca')
    payment_date(Date.current.beginning_of_month + 3)
  end
end
