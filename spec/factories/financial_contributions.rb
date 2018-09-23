FactoryBot.define do
  factory :financial_contribution do
    before(:create) do |financial_contribution|
      if User.all.count == 0
        user = FactoryBot.create(:user)
        financial_contribution.user = user
      else
        user = User.first
        financial_contribution.user = user
      end
    end

    desc('IVA')
    total(10.3)
    date(Date.today())

    trait :type_one do
      contribution_type_id(1)
    end

    trait :type_two do
      contribution_type_id(2)
    end
  end
end
