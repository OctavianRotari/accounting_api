FactoryBot.define do
  factory :other_expense do
    user(User.first)
    desc('caffe')
    total(10.3)
    date(Date.today())
  end
end
