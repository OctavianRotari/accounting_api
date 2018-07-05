FactoryBot.define do
  factory :vehicle do
    user
    plate('EH535RV')
    vehicle_type
    charge_general_expenses(true)
    roadworthiness_check_date(Date.today.next_month)
  end
end
