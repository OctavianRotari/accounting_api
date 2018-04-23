FactoryBot.define do
  factory :other_expense do
    desc('caffe')
    total(10.3)
    date(Date.today())
  end
end
