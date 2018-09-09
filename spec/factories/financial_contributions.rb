FactoryBot.define do
  factory :financial_contribution do
    user(User.first)
    desc('IVA')
    total(10.3)
    date(Date.today())
    contribution_type_id(1)
  end
end
