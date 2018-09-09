FactoryBot.define do
  factory :vehicle_type do
    user(User.first)
    desc "MyString"
  end
end
