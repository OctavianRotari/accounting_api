FactoryBot.define do
  factory :vehicle do
    before(:create) do |vehicle|
      if !vehicle.user_id
        if User.all.count == 0
          user = FactoryBot.create(:user)
          vehicle.user = user
        else
          user = User.first
          vehicle.user = user
        end
      end
    end

    plate('EH535RV')
    charge_general_expenses(true)
    roadworthiness_check_date(Date.today.next_month)
    vehicle_type_id(1)

    trait :type_two do
      vehicle_type_id(2)
    end
  end
end
