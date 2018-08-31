FactoryBot.define do
  factory :invoice do
    before(:create) do |invoice|
      invoice.line_items << FactoryBot.create(:line_item, invoice: invoice)
    end
    vendor
    date(Date.today())
    deadline(Date.today.next_month())
    description("Pezzi di ricambio")
    serial_number("09243vs")
  end
end
