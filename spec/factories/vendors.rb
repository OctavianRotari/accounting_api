FactoryBot.define do
  factory :vendor do
    user
    adress('5 fowler terrace')
    name('Taste good')
    number('3451374143')
  end
end
