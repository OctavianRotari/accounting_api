FactoryBot.define do
  factory :maintenance do
    vehicle
    date(Date.today.prev_month)
    deadline(Date.today)
    desc('olio motore')
    km(124432)

    factory :maintenance_next_month do
      deadline(Date.today.next_month)
      desc('filtro aria')
      km(124432)
    end
  end
end
