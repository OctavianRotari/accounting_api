FactoryBot.define do
  factory :invoice do
    vendor
    date(Date.today())
    deadline(Date.today.next_month())
    description("Pezzi di ricambio")
    serial_number("09243vs")

    trait :items do
      after(:create) do |invoice|
        FactoryBot.create(:line_item, invoice_id: invoice.id)
        FactoryBot.create(:line_item, invoice_id: invoice.id)
      end
    end

    trait :fuel_receipts do
      before(:create) do |invoice|
        user = User.first
        vendor = FactoryBot.create(:vendor, user_id: user.id)
        vehicle_type = FactoryBot.create(:vehicle_type, user_id: user.id)
        vehicle = FactoryBot.create(
          :vehicle, 
          vehicle_type_id: vehicle_type.id, 
          user_id: user.id
        )
        FactoryBot.create(
          :fuel_receipt, 
          vehicle_id: vehicle.id, 
          vendor_id: vendor.id
        )
      end
    end
  end
end
