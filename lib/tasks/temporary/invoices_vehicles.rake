namespace :invoices_vehicles do
  desc 'Move vehicle id, invoice id and total to invoices_vehicles'
  task move_vehicle_fields_to_invoices_vehicles: :environment do
    vehicleFields = VehicleField.all()
    puts "Going to move #{vehicleFields.count} ids"
    values = vehicleFields.map {|field| "(#{field.vehicle_id}, #{field.invoice_id}, #{field.part_of_total})"}.join(",")
    ActiveRecord::Base.connection.execute("INSERT INTO invoices_vehicles (vehicle_id, invoice_id, total) VALUES #{values}")
    puts 'all done'
  end
end
