FactoryBot.define do
  factory :other_expense do
    user
    desc('caffe')
    total(10.3)
    date(Date.today())
  end
end
