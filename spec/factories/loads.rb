FactoryBot.define do
  factory :load do
    vendor
    from("Ravenna, via dell'abbondanza 7")
    to("Milano, via giorgino 8")
    serial_number("5kfds3s")
    weight(30000)
    date(Date.current.beginning_of_month + 3)
    desc('Metallo')
    price(300.20)
  end
end
