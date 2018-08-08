FactoryBot.define do
  factory :credit_note do
    vendor
    date(DateTime.new())
    total('100')
  end
end
