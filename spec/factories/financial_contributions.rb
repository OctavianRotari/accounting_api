FactoryBot.define do
  factory :financial_contribution do
    desc('caffe')
    total(10.3)
    date(Date.today())
  end
end
