FactoryBot.define do
  factory :employee do
    user
    name('Luigi')
    contract_start_date(Date.today())
    role('Camionista')
  end
end
