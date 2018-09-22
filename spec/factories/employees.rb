FactoryBot.define do
  factory :employee do
    before(:create) do |employee|
      if User.all.count == 0
        user = FactoryBot.create(:user)
        employee.user = user
      else
        user = User.first
        employee.user = user
      end
    end

    name('Luigi')
    contract_start_date(Date.today())
    role('Camionista')
  end
end
