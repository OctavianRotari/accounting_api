FactoryBot.define do
  factory :vehicle do
    before(:create) do |vehicle|
      if User.all.count == 0
        user = FactoryBot.create(:user)
        vehicle.user = user
      else
        user = User.first
        vehicle.user = user
      end
    end

    plate('EH535RV')
    charge_general_expenses(true)
    roadworthiness_check_date(Date.today.next_month)

    trait :type_one do
      vehicle_type_id(1)
    end

    trait :type_two do
      vehicle_type_id(2)
    end
  end
end
