FactoryBot.define do
  factory :sanction do
    before(:create) do |vendor|
      if User.all.count == 0
        user = FactoryBot.create(:user)
        vendor.user = user
      else
        user = User.first
        vendor.user = user
      end
    end

    total(1600.22)
    date(Date.today.last_month.beginning_of_month)
    description('multa')
    deadline(Date.today + 5)
  end
end
