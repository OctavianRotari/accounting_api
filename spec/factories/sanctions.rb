FactoryBot.define do
  factory :sanction do
    user
    total(1600.22)
    date(Date.today.last_month.beginning_of_month)
    deadline(Date.today + 5)
  end
end
