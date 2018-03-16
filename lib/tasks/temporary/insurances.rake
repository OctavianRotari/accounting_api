namespace :insurances do
  desc 'Move vehicle id, ticket id to tickets_vehicles'
  task move_vehicle_id_to_insurances_vehicles: :environment do
    insurances = Insurance.where(at_the_expense_of: 'specific_vehicle')
    puts "Going to move #{insurances.count} ids"
    values = insurances.map {|insurance| "(#{insurance.vehicle_id}, #{insurance.id})"}.join(",")
    ActiveRecord::Base.connection.execute("INSERT INTO insurances_vehicles (vehicle_id, insurance_id) VALUES #{values}")
  end
end
