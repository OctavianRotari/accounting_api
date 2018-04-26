FactoryBot.define do
  factory :vehicle do
    user
    plate('EH535RV')
    vehicle_type_id(1)
    charge_general_expenses(true)
  end
end
