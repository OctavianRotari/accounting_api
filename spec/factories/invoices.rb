FactoryBot.define do
  factory :invoice do
    vendor
    date_of_issue(Date.today())
    deadline(Date.today.next_month())
    description("Pezzi di ricambio")
    serial_number("09243vs")
  end
end
