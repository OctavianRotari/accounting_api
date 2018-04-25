FactoryBot.define do
  factory :salary do
    employee
    total(1600.22)
    month(Date.today.last_month.beginning_of_month)
    deadline(Date.today.beginning_of_month + 5)
  end
end
