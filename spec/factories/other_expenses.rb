FactoryBot.define do
  factory :other_expense do
    before(:create) do |other_expense|
      if User.all.count == 0
        user = FactoryBot.create(:user)
        other_expense.user = user
      else
        user = User.first
        other_expense.user = user
      end
    end

    desc('caffe')
    total(10.3)
    date(Date.today())
  end
end
