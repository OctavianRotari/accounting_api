namespace :tickets do
  desc 'Move vehicle id, ticket id to tickets_vehicles'
  task move_vehicle_id_to_tickets_vehicles: :environment do
    tickets = Ticket.where(type_of: 1)
    puts "Going to move #{tickets.count} ids"
    values = tickets.map { |ticket| "(#{ticket.vehicle_id}, #{ticket.id})" }.join(",")
    ActiveRecord::Base.connection.execute("INSERT INTO tickets_vehicles (vehicle_id, ticket_id) VALUES #{values}")
  end
end
