FactoryBot.define do
  factory :vendor do
    before(:create) do |vendor|
      if !vendor.user_id 
        if User.all.count == 0
          user = FactoryBot.create(:user)
          vendor.user = user
        else
          user = User.first
          vendor.user = user
        end
      end
    end

    address('5 fowler terrace')
    name('Taste good')
    number('3451374143')
  end
end
