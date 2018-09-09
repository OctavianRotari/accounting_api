FactoryBot.define do
  factory :vendor do
    user(User.first)
    address('5 fowler terrace')
    name('Taste good')
    number('3451374143')
  end
end
