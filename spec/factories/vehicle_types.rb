FactoryBot.define do
  factory :vehicle_type do
    before(:create) do |vehicle|
      if User.all.count == 0
        user = FactoryBot.create(:user)
        vehicle.user = user
      else
        user = User.first
        vehicle.user = user
      end
    end

    desc "My vehicle type"
  end
end
