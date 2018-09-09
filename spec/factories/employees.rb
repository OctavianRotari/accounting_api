FactoryBot.define do
  factory :employee do
    user(User.first)
    name('Luigi')
    contract_start_date(Date.today())
    role('Camionista')
  end
end
